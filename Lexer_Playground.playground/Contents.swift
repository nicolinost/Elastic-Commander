//: Playground - noun: a place where people can play

import Cocoa

var str = "PUT _kmcloud_percolator/_settings/_bla { \"query\" : \"query_string\" : [{ \"filter\" : \"filtered\"} ,{ }] }"

public enum	TokenType{
	case HTTP_VERB
	case STRING_LITERAL
	case URL_ENDPOINT
	case API
	case L_CURLY_BRACKET
	case R_CURLY_BRACKET
	case COLON
	case L_SQUARE_ARRAY
	case R_SQUARE_ARRAY
	case COMMA
}

public class Token:NSObject{
	let TYPE:TokenType;
	let VALUE:String;
	
	init(type:TokenType,value:String){
		self.TYPE = type;
		self.VALUE = value;
	}
	
	
	override public var description: String{
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


func FormTokenWithChars(startPoint:Int, endPoint:Int, lemme:String, TOKEN_TYPE:TokenType, includeLast:Bool)-> Token{
	
	let lexeme = GetStringByRange(startPoint, endPoint: endPoint, lemme: lemme, includeLast: includeLast);
	
	return Token(type: TOKEN_TYPE, value: lexeme);
}

func LexStringLiteral(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int) {
	var i = AdvanceChar(CurPtr);
	while (i < lemme.characters.count) {
		if(lemme[lemme.startIndex.advancedBy(i)] == "\""){
			let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: i, lemme: lemme, TOKEN_TYPE: TokenType.STRING_LITERAL, includeLast: false);
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
			let token = FormTokenWithChars(CurPtr, endPoint: i, lemme: lemme, TOKEN_TYPE: TokenType.HTTP_VERB, includeLast: false);
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
			let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: (IsEndOfLemme) ? AdvanceChar(i) : i, lemme: lemme, TOKEN_TYPE: TokenType.URL_ENDPOINT, includeLast: false);
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
			let token = FormTokenWithChars(CurPtr, endPoint: (IsEndOfLemme) ? AdvanceChar(i) : i, lemme: lemme, TOKEN_TYPE: TokenType.API, includeLast: false);
			return (token,(IsEndOfLemme) ? AdvanceChar(i) : i);
		}
		i += 1;
	}
	return (nil,i);
}


func LexRawLine(line:String) -> Array<Token?> {
	
	var tokens : Array<Token?> = Array();
	
	var index = 0
	let unicode = String(line).unicodeScalars;
	while(index < line.characters.count)
	{
		
		let uniChar = unicode[unicode.startIndex.advancedBy(index)];
		
		switch uniChar{
			
		case "{":
			//print("IS L_CURLY_BRACKET")
			let token = Token(type: TokenType.L_CURLY_BRACKET, value: "{");
			tokens.append(token);
			index += 1;
		case "}":
			//print("IS R_CURLY_BRACKET")
			let token = Token(type:TokenType.R_CURLY_BRACKET,value: "}");
			tokens.append(token);
			index += 1;
		case "[":
			//print("IS L_SQUARE_BRACKET")
			let token = Token(type:TokenType.L_SQUARE_ARRAY,value:"[");
			tokens.append(token);
			index+=1;
		case "]":
			//print("IS R_SQUARE_BRACKET")
			let token = Token(type: TokenType.R_SQUARE_ARRAY, value: "]");
			tokens.append(token);
			index+=1;
		case ",":
			//print("IS COMMA")
			let token = Token(type: TokenType.COMMA, value: ",");
			tokens.append(token);
			index+=1;
		case "\"":
			//print("IS STRING LITERAL");
			let tokenizeResult = LexStringLiteral(index, lemme: str);
			tokens.append(tokenizeResult.tokenResult);
			index = tokenizeResult.nextPtr;
		case "/":
			//print("IS SLASH");
			if(unicode[unicode.startIndex.advancedBy(index+1)] != "_") {
				let tokenizeResult = LexUrlEndPoint(index,lemme:str);
				tokens.append(tokenizeResult.tokenResult);
				index = tokenizeResult.nextPtr;
			}
			else {
				let tokenizeResult = LexUrlApi(index+1, lemme: str);
				tokens.append(tokenizeResult.tokenResult);
				index = tokenizeResult.nextPtr;
			}
		case "_":
			//print("IS UNDERSCORE");
			let tokenizeResult = LexUrlApi(index, lemme: str);
			tokens.append(tokenizeResult.tokenResult);
			index = tokenizeResult.nextPtr;
		case "a","b","c","d","e","f","g","h","i","j","k","l","m",
		     "n","o","p","q","r","s","t","u","v","w","x","y","z",
		     "A","B","C","D","E","F","G","H","I","J","K","L","M",
		     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
			//print("IS IDENTIFIER");
			let tokenizeResult = LexIdentifier(index, lemme: str);
			tokens.append(tokenizeResult.tokenResult);
			index = tokenizeResult.nextPtr;
		case ":":
			let token = Token(type: TokenType.COLON, value: ":")
			tokens.append(token);
			index += 1;
		default:
			index += 1;
			
		}
	}
	
	return tokens;
}


let tokenArray = LexRawLine(str);

for token in tokenArray{
	print(token)
}


