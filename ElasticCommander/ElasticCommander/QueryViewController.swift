//
//  QueryViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa


class QueryViewController : NSViewController{
	
	@IBOutlet var queryEditor: NSTextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let font = NSFont(name: "Menlo", size: 12)
		queryEditor.font = font
		queryEditor.textColor = NSColor.greenColor()
	}
	
	func setQuery(newQuery : String)->Void{
		queryEditor.string = newQuery
	}
	
	func getQuery() -> String {
		return ((queryEditor.textStorage)?.string)!
	}
	
}