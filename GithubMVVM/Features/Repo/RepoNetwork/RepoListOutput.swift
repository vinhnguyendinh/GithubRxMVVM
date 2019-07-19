//
//  RepoListOutput.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import ObjectMapper

class RepoListOutput: APIOutputBase {
    
    var repositories: [RepoModel]?

    required init(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        self.repositories <- map["items"]
    }
    
}
