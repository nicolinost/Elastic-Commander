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
	public var name : String {
		get {
			return _name
		}
	}
	
	public var childrenCount: Int{
		get{
			return (childrenNodes != nil) ? childrenNodes!.count : 0
		}
	}
	
	var indices : [Index]? = [Index]()
	public var childrenNodes: [TreeNode]?{
		get {
			return indices
		}
	}
	
	
	public override init(){
		_name = ""
		indices = [Index]?()
		super.init()
	}
	
	public init(name : String, indices : [Index]?){
		self._name = name
		self.indices = indices
	}
	
	@objc public func addChildrenNode(node: TreeNode) {
		indices?.append(node as! Index)
	}
	
	@objc public func addChildrensNode(nodes: [TreeNode]) {
		indices?.appendContentsOf(nodes as! [Index])
	}
	
}