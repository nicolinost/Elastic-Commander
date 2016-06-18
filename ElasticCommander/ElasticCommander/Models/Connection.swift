//
//  Connection.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 13/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public class Connection: NSObject{
	
	var name : String
	var indices : [Index]?
	
	
	override init(){
		name = ""
		indices = [Index]()
		super.init()
	}
	
	init(name : String, indices : [Index]){
		self.name = name
		self.indices = indices
	}
}