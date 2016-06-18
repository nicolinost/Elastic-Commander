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
	var indices : [Index] = []
	var mapping : [Mapping] = []
	
	
	override func viewDidLoad() {
		//Test initializer !!!
		mapping.append(Mapping(name:"Test mapping"))
		indices.append(Index(name: "Test Index", mappings: mapping))
		connections.append(Connection(name: "conn1", indices: indices))
		
		super.viewDidLoad()
	}
	
	//Return the right item
	func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
		switch item {
		case let connect as Connection:
			return connect.indices![index]
		default:
			return connections[index]
		}
	}
	
	//How many childen has the item ?
	func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
		if let item : AnyObject = item{
			switch item {
			case let connect as Connection:
				return connect.indices!.count
			case let index as Index:
				//mapping count + 1 (settings label)
				return index.mappings!.count + 1
			default:
				return 0
			}
		}
		else{
			return connections.count
		}
	}
	
	//Does the item is expandable ?
	func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
		switch item {
		case let connect as Connection:
			return (connect.indices?.count > 0) ? true : false
//		case _ as Index:
//			return true
		default:
			return false
		}
	}
	
	//Set the right UI property in function of the item pass by parameter, thanks to the delegate :)
	func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
		let view = outlineView.makeViewWithIdentifier("ConnectionName", owner: self) as! NSTableCellView
		if let textfield = view.textField{
			switch item {
			case let connect as Connection:
				textfield.stringValue = connect.name
			case let index as Index:
				textfield.stringValue = index.name
			default:
				break
			}
		}
		
		return view
	}
}