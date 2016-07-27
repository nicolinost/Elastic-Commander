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
	
	init(){
		
	}
	
	init(startPosition:Int, endPosition:Int){
		self.startPosition = startPosition
		self.endPosition = endPosition
	}
}

public struct BlockHeader {
	public var httpVerb : String = ""
	public var apiPath : String = ""
	
	init(){
		
	}
	
	init(httpVerb:String, apiPath:String){
		self.httpVerb = httpVerb
		self.apiPath = apiPath
	}
}

public class QueryBlock{
	
	public var queryString : String?
	public var header : BlockHeader = BlockHeader()
	public var queryPosition : BlockPosition = BlockPosition()
	
	
	init(){
		
	}
	
	convenience init(queryString : String, queryPosition : BlockPosition){
		self.init()
		self.queryString = queryString
		self.queryPosition = queryPosition
	}
	
	convenience init(queryString : String, header : BlockHeader, queryPosition : BlockPosition){
		self.init()
		
		self.queryString = queryString
		self.header = header
		self.queryPosition = queryPosition
	}
}