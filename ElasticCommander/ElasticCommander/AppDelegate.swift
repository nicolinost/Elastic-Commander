//
//  AppDelegate.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 15/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	var myWindowController : WindowController?
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		//No code for the moment
	}
	
	func applicationDidBecomeActive(notification: NSNotification) {
		
		let mainWindowController = NSApplication.sharedApplication().mainWindow?.windowController
		myWindowController = mainWindowController as? WindowController
		
	}
	
	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
	
	
	@IBAction func indentQuery(sender: AnyObject) {
		myWindowController?.IndentQuery(sender)
	}
}

