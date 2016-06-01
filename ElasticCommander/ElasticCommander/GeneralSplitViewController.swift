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
	
	func HideMenu() -> Void {
		menuConnections.hideMe()
	}
	
	func ShowMenu() -> Void {
		menuConnections.showMe()
	}
	
	
}