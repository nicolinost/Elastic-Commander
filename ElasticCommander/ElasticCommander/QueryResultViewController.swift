//
//  QueryResultViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa


class QueryResultViewController : NSViewController{
	
	@IBOutlet var queryResult: NSTextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let font = NSFont(name: "Menlo", size: 12)
		queryResult.font = font
		queryResult.textColor = NSColor.greenColor()
	}
	
	func setQueryResultText(queryResultStr : String){
		queryResult.string = queryResultStr
		
		queryResult.display()
	}
	
}