
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func hideMe(){
		self.view.hidden = true
	}
	
	func showMe(){
		self.view.hidden = false
	}
}