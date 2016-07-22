//
//  Query.swift
//  EditorCodeService
//
//  Created by Nicolas Sterchele on 22/07/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


public struct BlockPosition {
	var startPosition = 0
	var endPosition = 0
	
	init(startPosition:Int, endPosition:Int){
		self.startPosition = startPosition
		self.endPosition = endPosition
	}
}

public struct BlockHeader {
	var httpVerb : String
	var apiPath : String
	
	init(httpVerb:String, apiPath:String){
		self.httpVerb = httpVerb
		self.apiPath = apiPath
	}
}

public class QueryBlock{
	
	var queryString : String
	var header : BlockHeader
	var queryPosition : BlockPosition
	
	init(queryString : String, header : BlockHeader, queryPosition : BlockPosition){
		self.queryString = queryString
		self.header = header
		self.queryPosition = queryPosition
	}
}