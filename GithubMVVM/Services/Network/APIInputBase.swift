//
//  APIInputBase.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import Alamofire

class APIInputBase: NSObject {
    var header: [String: String] = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    
    let urlString: String
    
    let requestType: HTTPMethod
    
    let encoding: ParameterEncoding
    
    let parameters: [String: Any]?
    
    let requireAccessToken: Bool
    
    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod, requireAccessToken: Bool = true) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
    }
}
