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
	
	
	public static func AddTabs(nbTabs:Int) -> String {
		var result : String = ""
		
		for _ in 0..<nbTabs {
			result.appendContentsOf("\t")
		}
		
		return result
	}
	
	
	public static func IndentJson(str:String)-> String{
		
		var index = 0
		var offset = 0
		let unicode = str.unicodeScalars
		
		var result : String = ""
		
		while(index < str.characters.count){
			
			let uniChar = unicode[unicode.startIndex.advancedBy(index)]
			
			switch uniChar {
			case "{":
				offset += 1
				result.append(uniChar)
				result.appendContentsOf("\n" + AddTabs(offset))
				break
			case "}":
				offset -= 1
				result.appendContentsOf("\n" + AddTabs(offset))
				result.append(uniChar)
				break
			case ",":
				result.append(uniChar)
				result.appendContentsOf("\n" + AddTabs(offset))
			case "[":
				result.append(uniChar)
				result.appendContentsOf("\n")
				if unicode[unicode.startIndex.advancedBy(index+1)] == "{"{
					result.appendContentsOf(AddTabs(offset))
				}
				break
			case "]":
				result.appendContentsOf("\n")
				if unicode[unicode.startIndex.advancedBy(index-1)] == "}"{
					result.appendContentsOf(AddTabs(offset))
				}
				result.append(uniChar)
			default:
				result.append(uniChar)
				break
			}
			
			index += 1
			
		}
		
		return result
		
	}
	
}