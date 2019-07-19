//
//  RepoListInput.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import Foundation

class RepoListInput: APIInputBase {
    init() {
        super.init(urlString: URLs.repoList,
                   parameters: nil,
                   requestType: .get)
    }
}
