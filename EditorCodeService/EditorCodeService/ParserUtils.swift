//
//  ParserUtils.swift
//  EditorCodeService
//
//  Created by Nicolas Sterchele on 15/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


public class ParserUtils{
	
	public static func IsCharacter(supposedCharacter:UnicodeScalar) -> Bool {
		let charachtersSet = NSCharacterSet.letterCharacterSet();
		
		return charachtersSet.longCharacterIsMember(supposedCharacter.value);
	}
	
	public static func IsNumeric(supposedNumeric:UnicodeScalar) -> Bool{
		let numericSet = NSCharacterSet.decimalDigitCharacterSet();
		
		return numericSet.longCharacterIsMember(supposedNumeric.value);
	}
	
	public static func IsWhiteSpace(supposedWhiteSpace:Character) -> Bool{
		return supposedWhiteSpace == " ";
	}
	
	
	public static func IsWhiteSpace(supposedWhiteSpace:UnicodeScalar) -> Bool {
		let whitespaceSet = NSCharacterSet.whitespaceCharacterSet();
		
		return whitespaceSet.longCharacterIsMember(supposedWhiteSpace.value);
	}
	
	
	public static func GetStringByRange(startPoint:Int, endPoint:Int, lemme:String, includeLast:Bool)-> String{
		let range: Range<String.Index>;
		
		if(includeLast){
			range = lemme.startIndex.advancedBy(startPoint) ... lemme.startIndex.advancedBy(endPoint);
		}
		else{
			range = lemme.startIndex.advancedBy(startPoint) ..< lemme.startIndex.advancedBy(endPoint);
		}
		
		return lemme.substringWithRange(range);
	}

	
}