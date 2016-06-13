//
//  Connection.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 13/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


class Connection: NSObject{
	
	var name : String
	
	override init(){
		name = ""
		super.init()
	}
	
	init(name : String){
		self.name = name
	}
}