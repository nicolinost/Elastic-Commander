//
//  NetworkTests.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 26/03/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import XCTest
@testable import CommanderLibrary

class NetworkTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	
	
	func testSendAndReceivedNotNil(){
		//Arrange
		let hostToReach = "http://10.0.0.5:9200";
		let httpVerbeToUse = "GET";
		let apiToUse = "/";
		let bodyToSend: NSString? = nil;
		
		let request = Request<NSString>(host: hostToReach, httpVerb: httpVerbeToUse, api: apiToUse, body: bodyToSend);
		let expectation = expectationWithDescription("Getting data from elasticsearch")
		
		//Act
		do{
			_ = try Networks.SendAndReceiveDatas(request, callBack: {(data) in
				debugPrint(data);
				expectation.fulfill();
			});
			
			
			waitForExpectationsWithTimeout(1, handler: {error in
				if let error = error{
					XCTFail("waitForExpectationsWithTimeout ERRORED: \(error)");
				}
			})
		}
		catch{
			print(error)
		}
	}
	
}
