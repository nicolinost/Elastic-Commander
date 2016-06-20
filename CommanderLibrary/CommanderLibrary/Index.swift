//
//  Alias.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 16/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public class Index : NSObject, TreeNode{
	
	private var _name : String = ""
	public var name : String {
		get{
			return _name
		}
	}
	var mapping : Mapping?
	var settings : Settings = Settings(name: "Settings")
	var aliasName : String?
	
	public var childrenCount: Int{
		get{
			return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	private var nodes : [TreeNode] = [TreeNode]()
	public var childrenNodes: [TreeNode]?{
		get{
			return nodes as [TreeNode]
		}
	}
	
	public init(name:String){
		super.init()
		self._name = name
		addChildrenNode(settings)
	}
	
	public convenience init(name : String, mapping : Mapping?){
		self.init(name: name)
		self.mapping = mapping
		if mapping != nil {
			addChildrenNode(mapping!)
		}
	}
	
	public convenience init(name : String, mapping : Mapping?, aliasName : String){
		self.init(name:name, mapping: mapping)
		self.aliasName = aliasName
	}
	
	
	public func addChildrenNode(node: TreeNode) {
		self.nodes.append(node)
	}
	
	public func addChildrensNode(nodes: [TreeNode]) {
		self.nodes.appendContentsOf(nodes)
	}
	
	
}