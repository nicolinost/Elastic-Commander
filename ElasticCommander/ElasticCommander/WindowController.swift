//
//  WindowController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa
import EditorCodeService
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
	
	
	@IBAction func SendAction(sender: NSButton) {
		let myQueryBlock = self.splitViewController.getQuery(0)
		let request = Request(host: self.urlToSend.stringValue, httpVerb: (myQueryBlock?.header.httpVerb)!, api: (myQueryBlock?.header.apiPath)!, body:myQueryBlock?.queryString )
		
		do{
			try Networks.SendAndReceiveDatas(request, callBack: {(data) in
				NSOperationQueue.mainQueue().addOperationWithBlock({
					let queryIndented = SyntaxUtils.IndentJson(data as! String)
					self.splitViewController.querySplitView.setQueryResult(queryIndented)
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
	
	@IBAction func IndentQuery(sender: AnyObject) {
		NSOperationQueue.mainQueue().addOperationWithBlock({
			let myQueryBlock = self.splitViewController.getQuery(0)
			let queryIndented = SyntaxUtils.IndentJson((myQueryBlock?.queryString)!)
			self.splitViewController.setQuery(queryIndented)
		})
	}
	
}