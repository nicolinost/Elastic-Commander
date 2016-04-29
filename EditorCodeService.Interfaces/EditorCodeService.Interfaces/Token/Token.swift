//
//  Token.swift
//  EditorCodeServiceInterfaces
//
//  Created by Nicolas Sterchele on 29/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public enum	TokenType{
	case HTTP_VERB
	case STRING_LITERAL
	case URL_ENDPOINT
	case API
	case L_CURLY_BRACKET
	case R_CURLY_BRACKET
	case COLON
}


public protocol Token {
	
	var TYPE:TokenType{get};
	var VALUE:String{get};
	
	static func FormTokenWithChars(startPoint:Int, endPoint:Int, lemme:String, TOKEN_TYPE:TokenType, includeLast:Bool)-> Token;
	
}