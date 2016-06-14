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
	
	
	override func viewDidLoad() {
		connections.append(Connection(name: "localhost"))
		super.viewDidLoad()
	}
	
	func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
		return connections[0]
	}
	
	func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
		return 1
	}
	
	func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
		return false
	}
	
	func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
		let view = outlineView.makeViewWithIdentifier("ConnectionName", owner: self) as! NSTableCellView
		if let textfield = view.textField{
			textfield.stringValue = (item as! Connection).name
		}
		
		return view
	}
}