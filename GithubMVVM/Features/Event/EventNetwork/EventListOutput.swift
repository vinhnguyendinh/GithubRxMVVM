//
//  EventListOutput.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import ObjectMapper

class EventListOutput: APIOutputBase {
    var events: [EventModel] = []
    
    init(events: [EventModel]) {
        self.events = events
        super.init()
    }
    
    required init(map: Map) {
        super.init(map: map)
    }
}
