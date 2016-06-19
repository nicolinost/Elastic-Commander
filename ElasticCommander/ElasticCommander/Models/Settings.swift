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
	@objc var name : String {
		get{
			return _name
		}
	}
	
	@objc var childrenCount: Int {
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
	
	init(name : String){
		self._name = name
	}
	
	@objc func addChildrenNode(node: TreeNode) {
		nodes?.append(node)
	}
	
	@objc func addChildrensNode(nodes: [TreeNode]) {
		self.nodes?.appendContentsOf(nodes)
	}
	
}