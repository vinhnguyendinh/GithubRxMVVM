//
//  RepoService.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import RxSwift

protocol RepoServiceProtocol {
    func getRepoList(input: RepoListInput) -> Observable<RepoListOutput>
}

class RepoService: APIService, RepoServiceProtocol {
    func getRepoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return request(input)
            .observeOn(MainScheduler.instance)
            .share()
    }
}
