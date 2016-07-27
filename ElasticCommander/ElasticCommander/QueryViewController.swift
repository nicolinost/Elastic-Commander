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
	
	func getQuery(whichOne:Int) -> QueryBlock? {
		let queryEditorText = queryEditor.textStorage?.string
		let testQueryBlocks = SyntaxUtils.ExtractQueryBlocksFromString(queryEditorText!)
		
		if testQueryBlocks.count > 0{
			return testQueryBlocks[whichOne]
		}
		else{
			return nil
		}
		//return (queryEditor.textStorage?.string)!
	}
	
}