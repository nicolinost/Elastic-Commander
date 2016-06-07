//
//  WindowController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa
import CommanderLibrary

class WindowController : NSWindowController{
	
	@IBOutlet weak var urlToSend: NSTextField!
	@IBOutlet weak var viewSelector: NSSegmentedControl!
	
	
	override func windowDidLoad() {
		super.windowDidLoad()
		self.window!.titleVisibility = .Hidden
	}
	
	var splitViewController : GeneralSplitViewController{
		return self.contentViewController as! GeneralSplitViewController
	}
	
	
	
	
	let processingQueue:NSOperationQueue = {
		let result = NSOperationQueue()
		result.maxConcurrentOperationCount = 4
		return result
	}()
	
	@IBAction func SendAction(sender: NSButton) {
		
		let request = Request<NSString>(host: self.urlToSend.stringValue, httpVerb: "GET", api: "/", body: self.splitViewController.getQuery());
		
		do{
			try Networks.SendAndReceiveDatas(request, callBack: {(data) in
				NSOperationQueue.mainQueue().addOperationWithBlock({
					self.splitViewController.querySplitView.setQueryResult((data as! String))
				})
			})
		}
		catch{
			print(error)
		}
		
	}
	
	
	@IBAction func HandleViewsVisibility(sender: NSSegmentedControl) {
		if sender.isSelectedForSegment(0) {
			splitViewController.ShowMenu()
		}
		else{
			splitViewController.HideMenu()
		}
	}
}