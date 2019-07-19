//
//  EventModel.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import ObjectMapper

struct EventModel: Mappable {
    var id: String?
    var type: String?
    var avatarURLString: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        avatarURLString <- map["actor.avatar_url"]
    }
}
