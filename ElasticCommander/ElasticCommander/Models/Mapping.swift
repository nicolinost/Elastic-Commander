//
//  Mapping.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


class Mapping : TreeNode{
	
	private var _name = ""
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
	
	private var nodes : [TreeNode]?
	var childrenNodes: [TreeNode]?{
		get{
			return nil
		}
	}
	
	init(name:String){
		self._name = name
	}
	
	convenience init(name : String, nodes : [TreeNode]){
		self.init(name:name)
		self.nodes = nodes
	}
	
	
	func addNode(node : TreeNode) -> Void {
		nodes?.append(node)
	}
	
	func addNodes(nodes : [TreeNode]) -> Void{
		self.nodes?.appendContentsOf(nodes)
	}
}