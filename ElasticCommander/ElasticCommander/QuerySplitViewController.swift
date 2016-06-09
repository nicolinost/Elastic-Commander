//
//  SplitViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa


class QuerySplitViewController : NSSplitViewController{
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	private var queryViewController : QueryViewController{
		let queryView = self.splitViewItems[0] as NSSplitViewItem
		return queryView.viewController	as! QueryViewController
	}
	
	private var queryResultViewController : QueryResultViewController{
		let queryResultView = self.splitViewItems[1] as NSSplitViewItem
		return queryResultView.viewController as! QueryResultViewController
	}
	
	func getQuery() -> String? {
		let query = queryViewController.getQuery()
		if(query == ""){
			return nil
		}
		return query
	}
	
	func setQuery(newQuery : String) -> Void{
		queryViewController.setQuery(newQuery)
	}
	
	func setQueryResult(result : String) {
		queryResultViewController.setQueryResultText(result)
	}
}