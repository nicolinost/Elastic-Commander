//
//  SyntaxUtils.swift
//  EditorCodeService
//
//  Created by Nicolas Sterchele on 04/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


public class SyntaxUtils{
	
	public static func IsHomogenBrackets(queryToAnalyse : String) -> Bool {
		let unicode = queryToAnalyse.unicodeScalars
		var index = 0
		var curlyBracketsCount = 0
		var squareBracketsCount = 0
		
		while index < queryToAnalyse.characters.count{
			let char = unicode[unicode.startIndex.advancedBy(index)]
			
			switch(char){
			case "{":
				curlyBracketsCount += 1
				break
			case "}":
				curlyBracketsCount -= 1
				break
			case "[":
				squareBracketsCount += 1
				break
			case "]":
				squareBracketsCount -= 1
				break
			default: break
			}
			index += 1
		}
		
		return curlyBracketsCount == 0 && squareBracketsCount == 0
	}
	
}