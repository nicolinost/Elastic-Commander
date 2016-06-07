//
//  GeneralSplitViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 01/06/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa

class GeneralSplitViewController : NSSplitViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	var menuConnections : ConnectionsMenuController{
		get{
			let splitItem = self.splitViewItems[0] as NSSplitViewItem
			return splitItem.viewController as! ConnectionsMenuController
		}
	}
	
	var querySplitView : QuerySplitViewController{
		get{
			let splitItem = self.splitViewItems[1] as NSSplitViewItem
			return splitItem.viewController as! QuerySplitViewController
		}
	}
	
	
	func getQuery() -> String? {
		return querySplitView.getQuery()
	}
	
	func ToggleMenu() -> Void {
		if splitView.isSubviewCollapsed(self.splitView.subviews[0]){
			ShowMenu()
		}else{
			HideMenu()
		}
	}
	
	func HideMenu() -> Void {
		let mainView = self.splitView.subviews[1]
		let connectionMenuView = self.splitView.subviews[0]
		connectionMenuView.hidden = true
		let mainFrame = self.splitView.frame
		
		mainView.frame.size = NSMakeSize(mainFrame.size.width,mainFrame.size.height)
		self.view.display()
	}
	
	func ShowMenu() -> Void {
		let connectionMenuView = self.splitView.subviews[0]
		connectionMenuView.hidden = false
		
		var connectionFrame = connectionMenuView.frame
		connectionFrame.size = NSMakeSize(300, self.splitView.frame.size.height)
	}
	
}