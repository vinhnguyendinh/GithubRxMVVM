//
//  URLs.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import Foundation

struct URLs {
    static let repoList = "https://api.github.com/search/repositories?q=language:swift&per_page=20"
    static let eventList = "https://api.github.com/repos/%@/events?per_page=15"
}
