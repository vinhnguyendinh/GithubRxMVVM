//
//  EventListInput.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import RxSwift
import ObjectMapper

class EventListInput: APIInputBase {
    init(repoFullName: String) {
        super.init(urlString: String(format: URLs.eventList, repoFullName),
                   parameters: nil,
                   requestType: .get)
    }
}
