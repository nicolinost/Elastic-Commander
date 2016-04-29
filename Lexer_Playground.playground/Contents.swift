//: Playground - noun: a place where people can play

import Cocoa

var str = "PUT /kmcloud_percolator/_settings { \"query\" : \"query_string\" { } }"


class Token:NSObject{
	let TYPE:String;
	let VALUE:String;
	
	init(type:String,value:String){
		self.TYPE = type;
		self.VALUE = value;
	}
	
	override var description: String{
		return "Type : \(TYPE) ; Value : \(VALUE)";
	}
}

func IsCharacter(supposedCharacter:UnicodeScalar) -> Bool {
	let charachtersSet = NSCharacterSet.letterCharacterSet();
	
	return charachtersSet.longCharacterIsMember(supposedCharacter.value);
}

func IsNumeric(supposedNumeric:UnicodeScalar) -> Bool{
	let numericSet = NSCharacterSet.decimalDigitCharacterSet();
	
	return numericSet.longCharacterIsMember(supposedNumeric.value);
}

func IsWhiteSpace(supposedWhiteSpace:Character) -> Bool{
	return supposedWhiteSpace == " ";
}

func IsWhiteSpace(supposedWhiteSpace:UnicodeScalar) -> Bool {
	let whitespaceSet = NSCharacterSet.whitespaceCharacterSet();
	
	return whitespaceSet.longCharacterIsMember(supposedWhiteSpace.value);
}

func GetStringByRange(startPoint:Int, endPoint:Int, lemme:String, includeLast:Bool)-> String{
	let range: Range<String.Index>;
 
	if(includeLast){
		range = lemme.startIndex.advancedBy(startPoint) ... lemme.startIndex.advancedBy(endPoint);
	}
	else{
		range = lemme.startIndex.advancedBy(startPoint) ..< lemme.startIndex.advancedBy(endPoint);
	}
	
	return lemme.substringWithRange(range);
}

func AdvanceChar(index:Int)->Int{
	return index + 1;
}


func FormTokenWithChars(startPoint:Int, endPoint:Int, lemme:String, TOKEN_TYPE:String, includeLast:Bool)-> Token{
	
	let lexeme = GetStringByRange(startPoint, endPoint: endPoint, lemme: lemme, includeLast: includeLast);
	
	return Token(type: TOKEN_TYPE, value: lexeme);
}

func LexStringLiteral(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int) {
	var i = AdvanceChar(CurPtr);
	while (i < lemme.characters.count) {
		if(lemme[lemme.startIndex.advancedBy(i)] == "\""){
			let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: i, lemme: lemme, TOKEN_TYPE: "STRING_LITERAL", includeLast: false);
			return (token,AdvanceChar(i));
		}
		i += 1;
	}
	return (nil,i);
}

func LexIdentifier(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int){
	var i = CurPtr;
	while (i < lemme.characters.count) {
		if(lemme[lemme.startIndex.advancedBy(i)] == " "){
			let token = FormTokenWithChars(CurPtr, endPoint: i, lemme: lemme, TOKEN_TYPE: "HTTP_VERB", includeLast: false);
			return (token,AdvanceChar(i));
		}
		i += 1;
	}
	return (nil,i);
}

func LexUrlEndPoint( CurPtr:Int, lemme:String)-> (tokenResult:Token?,nextPtr:Int) {
	var i = AdvanceChar(CurPtr);
	var IsEndOfLemme = false;
	while (i < lemme.characters.count) {
		IsEndOfLemme = i+1 == lemme.characters.count;
		if(lemme[lemme.startIndex.advancedBy(i)] == "/" || IsEndOfLemme){
			let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: (IsEndOfLemme) ? AdvanceChar(i) : i, lemme: lemme, TOKEN_TYPE: "URL_ENPOINT", includeLast: false);
			return (token,i);
		}
		i += 1;
	}
	return (nil,i);
}

func LexUrlApi(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int){
	var i = AdvanceChar(CurPtr);
	var IsEndOfLemme = false;
	while (i < lemme.characters.count) {
		IsEndOfLemme = i+1 == lemme.characters.count;
		if(lemme[lemme.startIndex.advancedBy(i)] == "/" || IsEndOfLemme || IsWhiteSpace(lemme[lemme.startIndex.advancedBy(i)])){
			let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: (IsEndOfLemme) ? AdvanceChar(i) : i, lemme: lemme, TOKEN_TYPE: "API", includeLast: false);
			return (token,(IsEndOfLemme) ? AdvanceChar(i) : i);
		}
		i += 1;
	}
	return (nil,i);
}


var index = 0
let unicode = String(str).unicodeScalars;
while(index < str.characters.count)
{
	
	let uniChar = unicode[unicode.startIndex.advancedBy(index)];
	
	switch uniChar{
		
	case "{":
		//print("IS L_CURLY_BRACKET")
		let token = Token(type: "L_CURLY_BRACKET", value: "{");
		print(token);
		index += 1;
	case "}":
		//print("IS R_CURLY_BRACKET")
		let token = Token(type:"R_CURLY_BRACKET",value: "}");
		print(token);
		index += 1;
	case "\"":
		//print("IS STRING LITERAL");
		let tokenizeResult = LexStringLiteral(index, lemme: str);
		print(tokenizeResult.tokenResult);
		index = tokenizeResult.nextPtr;
	case "/":
		//print("IS SLASH");
		if(unicode[unicode.startIndex.advancedBy(index+1)] != "_") {
			let tokenizeResult = LexUrlEndPoint(index,lemme:str);
			print(tokenizeResult.tokenResult);
			index = tokenizeResult.nextPtr;
		}
		else {
			let tokenizeResult = LexUrlApi(index, lemme: str);
			print(tokenizeResult.tokenResult);
			index = tokenizeResult.nextPtr;
		}
	case "_":
		//print("IS UNDERSCORE");
		let tokenizeResult = LexUrlApi(index, lemme: str);
		print(tokenizeResult.tokenResult);
		index = tokenizeResult.nextPtr;
	case "a","b","c","d","e","f","g","h","i","j","k","l","m",
	     "n","o","p","q","r","s","t","u","v","w","x","y","z",
	     "A","B","C","D","E","F","G","H","I","J","K","L","M",
	     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
		//print("IS IDENTIFIER");
		let tokenizeResult = LexIdentifier(index, lemme: str);
		print(tokenizeResult.tokenResult);
		index = tokenizeResult.nextPtr;
	case ":":
		//print("IS COLON_LINKER")
		let token = Token(type: "COLON_LINKER", value: ":")
		print(token);
		index += 1;
	default:
		//print("OTHER");
		index += 1;
		
	}
	
	
	
}

