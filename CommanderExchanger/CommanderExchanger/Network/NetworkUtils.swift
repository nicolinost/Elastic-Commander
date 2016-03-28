//
//  NetworkUtils.swift
//  CommanderExchanger
//
//  Created by Nicolas Sterchele on 25/03/16.
//  Copyright © 2016 ScienceHome. All rights reserved.
//

import Foundation

public class Request<T>{
    var host:String="";
    var httpVerb:String="";
    var api:String="";
    var body: T;
    
    var completeUrl:String {
        get{
            return host+""+api;
        }
    }
    
    
    init(host:String,httpVerb:String, api:String, body:T){
        self.host = host;
        self.httpVerb = httpVerb;
        self.api = api;
        self.body = body;
    }
}

public class Networks {
    
    ///Test Description
    public static func SendAndReceiveDatas<T>(request:Request<T>, callBack:(AnyObject)->()) throws  ->String{
        
        guard let url = NSURL(string:request.completeUrl) else {
            print("Error: cannot create URL");
            throw NetworkError.WrongUrl;
        }
        
        let urlRequest = NSURLRequest(URL: url);
        let config = NSURLSessionConfiguration.defaultSessionConfiguration();
        let session = NSURLSession(configuration: config);
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler:{(data,urlResponse, error) in
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
    
    private static func completionHandler (data:NSData? , urlResponse : NSURLResponse?, error : NSError?) -> Void{
        
        print(data);
        
        guard let responseData = data else {
            print("Error: no data received");
            return;
        }
        
        
        guard error == nil else {
            print(error)
            return;
        }
        
        
        let dataString = NSString(data: responseData, encoding: NSUTF8StringEncoding);
        print(dataString);
        
    }
    
}