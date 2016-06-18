//
//  Alias.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

class Index : NSObject{
	
	var name = ""
	var mappings = [Mapping]?()
	var settings : Settings = Settings(name: "Settings")
	var aliasName : String?
	
	init(name:String){
		self.name = name
	}
	
	convenience init(name : String, mappings : [Mapping]){
		self.init(name: name)
		self.mappings = mappings
	}
	
	convenience init(name : String, mappings : [Mapping], aliasName : String){
		self.init(name:name, mappings: mappings)
		self.aliasName = aliasName
	}
}