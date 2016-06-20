//
//  Settings.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public class Settings : TreeNode{
	
	private var _name : String
	@objc public  var name : String {
		get{
			return _name
		}
	}
	
	@objc public var childrenCount: Int {
		get{
		 return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	
	private var nodes : [TreeNode]? = [TreeNode]()
	@objc public var childrenNodes: [TreeNode]?{
		get{
			return nodes
		}
	}
	
	public init(name : String){
		self._name = name
	}
	
	@objc public func addChildrenNode(node: TreeNode) {
		nodes?.append(node)
	}
	
	@objc public func addChildrensNode(nodes: [TreeNode]) {
		self.nodes?.appendContentsOf(nodes)
	}
	
}