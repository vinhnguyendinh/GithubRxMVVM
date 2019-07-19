//
//  EventViewModel.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

class EventViewModel {
    let eventService: EventServiceProtocol
    let bag = DisposeBag()
    
    // MARK: - Input
    private(set) var repo: BehaviorRelay<RepoModel>
    
    // MARK: - Output
    private(set) var eventList: BehaviorRelay<[EventModel]>
    
    init(eventService: EventServiceProtocol, repo: BehaviorRelay<RepoModel>) {
        self.eventService = eventService
        self.repo = repo
        
        self.eventList = BehaviorRelay<[EventModel]>(value: [])
        
        bindOutput()
    }
    
    private func bindOutput() {
        repo.asObservable()
            .filter { $0.fullname != nil && !$0.fullname!.isEmpty }
            .map { $0.fullname! }
            .flatMap({ repoFullName -> Observable<EventListOutput> in
                return self.eventService.getEventList(input: EventListInput(repoFullName: repoFullName))
            })
            .subscribe(onNext: { (eventListOutput) in
                self.eventList.accept(eventListOutput.events)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: bag)
    }
}
