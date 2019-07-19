//
//  EventService.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import RxSwift

protocol EventServiceProtocol {
    func getEventList(input: EventListInput) -> Observable<EventListOutput>
}

class EventService: APIService, EventServiceProtocol {
    func getEventList(input: EventListInput) -> Observable<EventListOutput> {
        return requestArray(input)
            .observeOn(MainScheduler.instance)
            .map({ (events) -> EventListOutput in
                return EventListOutput(events: events)
            })
            .share()
    }
}
