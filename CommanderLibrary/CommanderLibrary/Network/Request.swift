//
//  Request.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 02/04/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import Foundation

public class Request{
	public var endPoint:String="";
	public var httpVerb:String="";
	public var api:String="";
	public var body: String?;
	
	var completeUrl:String {
		get{
			return endPoint+""+api;
		}
	}
	
	public init(host:String,httpVerb:String, api:String, body:String?){
		self.endPoint = host;
		self.httpVerb = httpVerb;
		self.api = api;
		self.body = body;
	}
	
	public func SerializeBody()->NSData?{
		do{
			let httpBody = try NSJSONSerialization.dataWithJSONObject(self.body!, options: NSJSONWritingOptions());
			return httpBody;
		}
		catch{
			print("Error: serialization error");
			return nil;
		}
	}
	
}

