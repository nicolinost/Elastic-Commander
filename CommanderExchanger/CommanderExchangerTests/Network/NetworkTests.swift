//
//  NetworkTests.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 26/03/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import XCTest
@testable import CommanderExchanger

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
        let hostToReach = "http://192.168.56.5:9200";
        let httpVerbeToUse = "GET";
        let apiToUse = "/_alias";
        let bodyToSend: NSString? = "";
        
        let request = Request<NSString>(host: hostToReach, httpVerb: httpVerbeToUse, api: apiToUse, body: bodyToSend!);
        let expectation = expectationWithDescription("Getting data from elasticsearch")
        
        //Act
        do{
            let result = try Networks.SendAndReceiveDatas(request, callBack: {(data) in
                print(data);
                expectation.fulfill();
            });
            //Assert
            XCTAssert(result != "", "Result is null !!");
            
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
