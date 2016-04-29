//
//  ParserUtils.swift
//  EditorCodeService
//
//  Created by Nicolas Sterchele on 29/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import EditorCodeServiceInterfaces

public class LexicalAnalyzer:LexicalAnalysing{
	
	public	func LexStringLiteral(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int) {
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
	
	public	func LexIdentifier(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int){
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
	
	public	func LexUrlEndPoint( CurPtr:Int, lemme:String)-> (tokenResult:Token?,nextPtr:Int) {
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
	
	public	func LexUrlApi(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int){
		var i = AdvanceChar(CurPtr);
		var IsEndOfLemme = false;
		while (i < lemme.characters.count) {
			IsEndOfLemme = i+1 == lemme.characters.count;
			if(lemme[lemme.startIndex.advancedBy(i)] == "/" || IsEndOfLemme || IsWhiteSpace(lemme[lemme.startIndex.advancedBy(i)])){
				let token = FormTokenWithChars(AdvanceChar(CurPtr), endPoint: (IsEndOfLemme) ? AdvanceChar(i) : i, lemme: lemme, TOKEN_TYPE: TokenType.API, includeLast: false);
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
				let token = Token(type: TokenType.L_CURLY_BRACKET, value: "{");
				tokens.append(token);
				index += 1;
			case "}":
				let token = Token(type:TokenType.R_CURLY_BRACKET,value: "}");
				tokens.append(token);
				index += 1;
			case "\"":
				let tokenizeResult = LexStringLiteral(index, lemme: str);
				tokens.append(tokenizeResult.tokenResult);
				index = tokenizeResult.nextPtr;
			case "/":
				if(unicode[unicode.startIndex.advancedBy(index+1)] != "_") {
					let tokenizeResult = LexUrlEndPoint(index,lemme:str);
					tokens.append(tokenizeResult.tokenResult);
					index = tokenizeResult.nextPtr;
				}
				else {
					let tokenizeResult = LexUrlApi(index, lemme: str);
					tokens.append(tokenizeResult.tokenResult);
					index = tokenizeResult.nextPtr;
				}
			case "_":
				let tokenizeResult = LexUrlApi(index, lemme: str);
				tokens.append(tokenizeResult.tokenResult);
				index = tokenizeResult.nextPtr;
			case "a","b","c","d","e","f","g","h","i","j","k","l","m",
			     "n","o","p","q","r","s","t","u","v","w","x","y","z",
			     "A","B","C","D","E","F","G","H","I","J","K","L","M",
			     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
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
	
	
}