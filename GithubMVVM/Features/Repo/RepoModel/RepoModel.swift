//
//  RepoModel.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import ObjectMapper

struct RepoModel: Mappable {
    var id = 0
    var name: String?
    var fullname: String?
    var urlString: String?
    var starCount = 0
    var folkCount = 0
    var avatarURLString: String?
    
    init() {
        
    }
    
    init(name: String) {
        self.name = name
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullname <- map["full_name"]
        urlString <- map["html_url"]
        starCount <- map["stargazers_count"]
        folkCount <- map["forks"]
        avatarURLString <- map["owner.avatar_url"]
    }
}
