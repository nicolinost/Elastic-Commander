//
//  QueryViewController.swift
//  ElasticCommander
//
//  Created by Nicolas Sterchele on 24/05/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation
import Cocoa
import EditorCodeService


class QueryViewController : NSViewController{
	
	@IBOutlet var queryEditor: NSTextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let font = NSFont(name: "Menlo", size: 12)
		queryEditor.font = font
		queryEditor.textColor = NSColor.blueColor()
		queryEditor.automaticQuoteSubstitutionEnabled = false
	}
	
	func setQuery(newQuery : String)->Void{
		queryEditor.string = newQuery
	}
	
	func getQuery() -> String {
		let queryEditorText = queryEditor.textStorage?.string
		let testQueryBlocks = SyntaxUtils.ExtractQueryBlocksFromString(queryEditorText!)
		
		return (queryEditor.textStorage?.string)!
	}
	
}