//
//  Connection.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 13/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public class Connection: NSObject, TreeNode{
	
	private var _name : String
	var name : String {
		get {
			return _name
		}
	}
	
	var childrenCount: Int{
		get{
			return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	
	var indices : [Index]?
	var childrenNodes: [TreeNode]?{
		get {
			return indices
		}
	}
	
	
	
	
	override init(){
		_name = ""
		indices = [Index]?()
		super.init()
	}
	
	init(name : String, indices : [Index]?){
		self._name = name
		self.indices = indices
		let test = indices as [TreeNode]?
	}
}