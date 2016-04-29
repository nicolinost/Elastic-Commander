//
//  LexicalAnalysing.swift
//  EditorCodeService.Interfaces
//
//  Created by Nicolas Sterchele on 29/04/16.
//  Copyright © 2016 nicolinoST. All rights reserved.
//

import Foundation

public protocol LexicalAnalysing{
	
	func LexStringLiteral(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int);
	
	func LexIdentifier(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int);
	
	func LexUrlEndPoint( CurPtr:Int, lemme:String)-> (tokenResult:Token?,nextPtr:Int);
	
	func LexUrlApi(CurPtr:Int, lemme:String) -> (tokenResult:Token?,nextPtr:Int);
	
	func LexRawLine(line:String) -> Array<Token?>;
	
}