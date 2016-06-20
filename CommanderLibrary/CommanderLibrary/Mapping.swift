//
//  Mapping.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


public class Mapping : TreeNode{
	
	private var _name = ""
	@objc public var name : String {
		get {
			return _name
		}
	}
	@objc public var childrenCount: Int{
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
	
	public init(name:String){
		self._name = name
	}
	
	public convenience init(name : String, nodes : [TreeNode]){
		self.init(name:name)
		self.nodes = nodes
	}
	
	
	@objc public func addChildrenNode(node: TreeNode) -> Void {
		nodes?.append(node)
	}
	
	@objc public func addChildrensNode(nodes: [TreeNode]) -> Void{
		self.nodes?.appendContentsOf(nodes)
	}
}