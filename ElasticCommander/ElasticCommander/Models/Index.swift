//
//  Alias.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

class Index : NSObject, TreeNode{
	
	private var _name : String
	var name : String {
		get{
			return _name
		}
	}
	var mapping : Mapping?
	var settings : Settings = Settings(name: "Settings")
	var aliasName : String?
	
	var childrenCount: Int{
		get{
			return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	private var nodes : [TreeNode] = [TreeNode]()
	var childrenNodes: [TreeNode]?{
		get{
			return nodes as [TreeNode]
		}
	}
	
	init(name:String){
		self._name = name
		self.nodes.append(settings)
	}
	
	convenience init(name : String, mapping : Mapping?){
		self.init(name: name)
		self.mapping = mapping
		nodes.append(settings)
		if mapping != nil {
			nodes.append(mapping!)
		}
	}
	
	convenience init(name : String, mapping : Mapping?, aliasName : String){
		self.init(name:name, mapping: mapping)
		self.aliasName = aliasName
	}
}