//
//  Networking.swift
//  ReadClient
//
//  Created by Sun,Kai(BBTD) on 27/10/2017.
//  Copyright © 2017 baidu. All rights reserved.
//

import Alamofire

class Networking: NSObject {
    
    enum RequestType: Int {
        case detail = 1
        case list = 2
    }
//
//    var type : RequestType = .list // qt 1:detail 2:list
//    var newsID : Int = 0 // id from:0
//    var count : Int = 1 // num
    
    class func requestNewsList(newsID: Int = 0, count: Int = 1, completionBlock: () -> Void) {
        let url = URL(string: Constant.BaseURLString + "?qt=2&id=" + String(newsID) + "&num=" + String(count))
        
        Alamofire.request(url!).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    class func requestDetail(newsID: Int = 0, completionBlock: () -> Void) {
        let url = URL(string: Constant.BaseURLString + "?qt=1&id=" + String(newsID) + "&num=1")
        
        Alamofire.request(url!).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }

}
