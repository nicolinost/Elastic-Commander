//
//  NetworkUtils.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 25/03/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import Foundation

public class Request<T:AnyObject>{
	var endPoint:String="";
	var httpVerb:String="";
	var api:String="";
	var body: T?;
	
	var completeUrl:String {
		get{
			return endPoint+""+api;
		}
	}
	
	init(host:String,httpVerb:String, api:String, body:T?){
		self.endPoint = host;
		self.httpVerb = httpVerb;
		self.api = api;
		self.body = body;
	}
	
	public func SerializeBody()->NSData?{
		do{
			let httpBody = try NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions());
			return httpBody;
		}
		catch{
			print("Error: serialization error");
			return nil;
		}
	}
	
}

public class Networks {
	
	
	///Test Description
	public static func SendAndReceiveDatas<T>(request:Request<T>, callBack:(AnyObject)->()) throws  ->String{
		
		guard let url = NSURL(string:request.completeUrl) else {
			print("Error: cannot create URL");
			throw NetworkError.WrongUrl;
		}
		
		let urlRequest = NSMutableURLRequest(URL: url);
		var httpMethod = request.httpVerb.uppercaseString;
		
		if(request.body != nil && httpMethod == "GET"){
			httpMethod = "POST";
		}
		if(httpMethod != "GET"){
			urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
			guard let httpBody = request.SerializeBody() else{
				throw NetworkError.NoBody;
			}
			urlRequest.HTTPBody = httpBody
		}
		
		urlRequest.HTTPMethod = httpMethod;
		let config = NSURLSessionConfiguration.defaultSessionConfiguration();
		let session = NSURLSession(configuration: config);
		
		let task = session.dataTaskWithRequest(urlRequest, completionHandler:{(data, urlResponse, error) in
			guard let responseData = data else {
				print("Error: no data received");
				return;
			}
			guard error == nil else {
				print(error);
				return;
			}
			
			let dataString = NSString(data: responseData, encoding: NSUTF8StringEncoding);
			
			callBack(dataString!);
		});
		
		task.resume();
		
		return "bla";
	}
	
}