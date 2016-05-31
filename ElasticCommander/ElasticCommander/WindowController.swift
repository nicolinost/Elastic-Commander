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
	
	
	override func windowDidLoad() {
		super.windowDidLoad()
	}
	
	var splitViewController : SplitViewController{
		return self.contentViewController as! SplitViewController
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
						self.splitViewController.setQueryResult(data as! String)
					})
				})
			}
			catch{
				print(error)
			}
		
	}
}