//
//  ConnectionOutlineViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 13/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa

class ConnectionOutlineViewController : NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource{
	
	var connections : [Connection] = []
	var indices : [Index]? = []
	var mapping : Mapping? = Mapping(name: "Mappings")
	
	
	override func viewDidLoad() {
		//Test initializer !!!
		mapping?.addNode(Mapping(name:"Test Mapping"))
		
		indices?.append(Index(name: "Test Index", mapping: mapping))
		connections.append(Connection(name: "conn1", indices: indices))
		
		super.viewDidLoad()
	}
	
	//Return the right item
	func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
		if let item : AnyObject = item{
			return (item as! TreeNode).childrenNodes![index]
			//			switch item {
			//			case let connect as Connection:
			//				return connect.indices![index]
			//			case let index as Index:
			//				return index.settings
			//			default:
			//				break
			//			}
		}
		else{
			return connections[index]
		}
	}
	
	//How many childen has the item ?
	func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
		
		if let node : AnyObject = item{
			return (node as! TreeNode).childrenCount
		}
		else{
			return connections.count
		}
		//		if let item : AnyObject = item{
		//			switch item {
		//			case let connect as Connection:
		//				return connect.indices!.count
		//			case let index as Index:
		//				//mapping count + 1 (settings label)
		//				return index.mappings!.count + 1
		//			default:
		//				return 0
		//			}
		//		}
		//		else{
		//			return connections.count
		//		}
	}
	
	//Does the item is expandable ?
	func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
		return ((item as! TreeNode).childrenCount > 0) ? true : false
		//		switch item {
		//		case let connect as Connection:
		//			return (connect.indices?.count > 0) ? true : false
		//		case _ as Index:
		//			return true
		//		default:
		//			return false
		//		}
	}
	
	//Set the right UI property in function of the item pass by parameter, thanks to the delegate :)
	func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
		let view = outlineView.makeViewWithIdentifier("ConnectionName", owner: self) as! NSTableCellView
		if let textfield = view.textField{
			textfield.stringValue = (item as! TreeNode).name
			//			switch item {
			//			case let connect as Connection:
			//				textfield.stringValue = connect.name
			//			case let index as Index:
			//				textfield.stringValue = index.name
			//			case let mapping as Mapping :
			//				textfield.stringValue = mapping.name
			//			case let settings as Settings:
			//				textfield.stringValue = settings.name
			//			default:
			//				break
			//			}
		}
		
		return view
	}
}