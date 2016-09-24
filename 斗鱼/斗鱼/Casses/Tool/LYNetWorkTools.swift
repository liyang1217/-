//
//  LYNetWorkTools.swift
//  TEXT
//
//  Created by BARCELONA on 2016/9/23.
//  Copyright © 2016年 LY. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{

    case GET
    case POST

}

class LYNetWorkTools {
    
    //? = nil
    class func GetRequestData(URLString: String, parameters: [String: NSString], responseObject: @escaping (_ result: AnyObject) -> ()){
        
        Alamofire.request(URLString).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            responseObject(result as AnyObject)
        }
        
    }
    
    class func PostRequestData(URLString: String, parameters: [String: NSString]? = nil, responseObject: @escaping (_ result: AnyObject) -> ()){
        
        Alamofire.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else{
                
                print(response.result.error)
                return
                
            }

            responseObject(result as AnyObject)
        
        }

        
    }

}









