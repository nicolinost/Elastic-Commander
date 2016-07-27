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
	
	
	public static func ExtractQueryBlocksFromString(str:String)-> Array<QueryBlock>{
		
		var index = 0
		let unicode = str.unicodeScalars
		var myQueryBlocksArray = Array<QueryBlock>()
		var myHeader  = BlockHeader()
		var myQueryBlock = QueryBlock()
		
		repeat{
			let char = unicode[unicode.startIndex.advancedBy(index)]
			
			switch char {
			case "{":
				var queryPosition = GetQueryPositionFromStartIndex(str, startIndex: index)
				myQueryBlock = GenerateQueryBlockFromPosition(str, blockPosition: &queryPosition)
				myQueryBlock.header = myHeader
				myQueryBlocksArray.append(myQueryBlock)
				index = queryPosition.endPosition
				myHeader = BlockHeader()
				myQueryBlock = QueryBlock()
				break
			default:
				var myBlockPosition = BlockPosition(startPosition: index, endPosition: 0)
				myHeader = GenerateBlockHeaderFromPosition(str, blockPosition: &myBlockPosition)
				myQueryBlock.header = myHeader
				index = myBlockPosition.endPosition
				break
			}
			
			index += 1
			
		} while index < str.characters.count
		
		if myQueryBlock.queryString == nil && myHeader.apiPath != "" {
			myQueryBlocksArray.append(myQueryBlock)
		}
		
		return myQueryBlocksArray
	}
	
	private static func GenerateQueryBlockFromPosition(str:String, inout blockPosition:BlockPosition) -> QueryBlock{
		
		var query = str.substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(blockPosition.startPosition), end: str.startIndex.advancedBy(blockPosition.endPosition+1)))
		
		return QueryBlock(queryString: query, queryPosition: blockPosition)
	}
	
	private static func GetQueryPositionFromStartIndex(query:String, startIndex:Int) -> BlockPosition{
		
		var index = startIndex
		var offset = 0
		let unicode = query.unicodeScalars
		
		var curlyBracketsCount = 0
		
		repeat{
			let char = unicode[unicode.startIndex.advancedBy(index)]
			
			switch char {
			case "{":
				curlyBracketsCount += 1
				break
			case "}":
				curlyBracketsCount -= 1
				if curlyBracketsCount == 0{
					return BlockPosition(startPosition: startIndex, endPosition: index)
				}
			default:
				break
			}
			
			index += 1
			
		} while index < query.characters.count || curlyBracketsCount == 0
		
		return BlockPosition(startPosition: startIndex, endPosition: index)
	}
	
	private static func GenerateBlockHeaderFromPosition(str:String, inout blockPosition:BlockPosition)-> BlockHeader{
		//Extract http verb and api path
		let unicode = str.unicodeScalars
		var i = blockPosition.startPosition
		
		repeat{
			i += 1
		}while i < str.characters.count && unicode[unicode.startIndex.advancedBy(i)] != "{"
		
		var fullPath = str.substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(blockPosition.startPosition), end: str.startIndex.advancedBy(i)))
		
		fullPath = fullPath.stringByReplacingOccurrencesOfString("\n", withString: "")
		
		let separatePath = fullPath.componentsSeparatedByString(" ")
		
		blockPosition.endPosition = i - 1
		return BlockHeader(httpVerb: separatePath[0], apiPath: separatePath[1])
	}
	
}