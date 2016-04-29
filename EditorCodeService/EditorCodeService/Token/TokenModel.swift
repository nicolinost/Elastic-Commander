//
//  TokenModel.swift
//  EditorCodeService
//
//  Created by Nicolas Sterchele on 29/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import EditorCodeServiceInterfaces

public class TokenModel : Token, NSObject{
	
	private var _TYPE:TokenType;
	public var TYPE :TokenType{
		get{
			return _TYPE;
		}
	}
	private var _VALUE:String;
	public var VALUE:String{
		get{
			return _VALUE;
		}
	}
	
	init(type:TokenType,value:String){
		self._TYPE = type;
		self._VALUE = value;
	}
	
	
	
	public static func FormTokenWithChars(startPoint: Int, endPoint: Int, lemme: String, TOKEN_TYPE: TokenType, includeLast: Bool) -> Token {
		let lexeme = GetStringByRange(startPoint, endPoint: endPoint, lemme: lemme, includeLast: includeLast);
		
		return Token(type: TOKEN_TYPE, value: lexeme);
	}
	
	
	override public var description: String{
		return "Type : \(TYPE) ; Value : \(VALUE)";
	}
}