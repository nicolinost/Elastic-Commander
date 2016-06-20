//
//  Tree.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 18/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation


@objc public protocol TreeNode : AnyObject{
	var name : String {get}
	var childrenNodes : [TreeNode]? {get}
	var childrenCount : Int {get}
	
	
	func addChildrenNode(node : TreeNode) -> Void
	func addChildrensNode(nodes : [TreeNode]) -> Void
}