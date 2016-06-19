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
	@objc var name : String {
		get {
			return _name
		}
	}
	@objc var childrenCount: Int{
		get{
			return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	
	private var nodes : [TreeNode]? = [TreeNode]()
	@objc var childrenNodes: [TreeNode]?{
		get{
			return nodes
		}
	}
	
	init(name:String){
		self._name = name
	}
	
	convenience init(name : String, nodes : [TreeNode]){
		self.init(name:name)
		self.nodes = nodes
	}
	
	
	@objc func addChildrenNode(node: TreeNode) -> Void {
		nodes?.append(node)
	}
	
	@objc func addChildrensNode(nodes: [TreeNode]) -> Void{
		self.nodes?.appendContentsOf(nodes)
	}
}