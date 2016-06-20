
//
//  ConnectionsViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 01/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa

class ConnectionsMenuController : NSViewController{
	
	@IBOutlet var addContextualMenu: NSMenu!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func hideMe(){
		self.view.hidden = true
	}
	
	func showMe(){
		self.view.hidden = false
	}
	
	
	@IBAction func showAddContextualMenu(sender: NSButton) {
		addContextualMenu.popUpMenuPositioningItem(nil, atLocation: NSEvent.mouseLocation(), inView: nil)
	}
	
	@IBAction func showAddConnectionSheet(sender: AnyObject) {
		
	}
}