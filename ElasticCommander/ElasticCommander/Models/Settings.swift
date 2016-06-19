//
//  Settings.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

class Settings : TreeNode{
	
	private var _name : String
	var name : String {
		get{
			return _name
		}
	}
	var childrenCount: Int {
		get{
		 return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	var childrenNodes: [TreeNode]?{
		get{
			return nil
		}
	}
	
	init(name : String){
		self._name = name
	}
	
}