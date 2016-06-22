//
//  AddConnectionController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 22/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa


class AddConnectionController : NSWindowController{
	
	
	@IBOutlet weak var urlConnection: NSTextField!
	
	override var windowNibName: String?{
		return "AddConnectionWindow"
	}
	
	@IBAction func okSaveMyConnection(button:NSButton){
		print("Ok hitted")
	}
	
	@IBAction func cancelSaveMyConnection(button:NSButton){
		print("Cancell hitted")
	}
	
}