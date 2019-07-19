//
//  RepoViewModel.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import RxSwift
import Action
import RxCocoa

protocol RepoViewModelProtocol {
    
}

class RepoViewModel: RepoViewModelProtocol {
    let repoService: RepoServiceProtocol
    let bag = DisposeBag()
    
    // MARK: - Input
    
    // MARK: - Output
    private(set) var repoList: BehaviorRelay<[RepoModel]>
    private(set) var isLoadingData = BehaviorRelay(value: false)
    
    private(set) var loadDataAction: Action<String, [RepoModel]>!
    
    init(repoService: RepoServiceProtocol) {
        self.repoService = repoService
        
        self.repoList = BehaviorRelay<[RepoModel]>(value: [])
        
        bindOutput()
    }
    
    private func bindOutput() {
        loadDataAction = Action { [weak self] sender in
            print(sender)
            self?.isLoadingData.accept(true)
            guard let this = self else { return Observable.never() }
            return this.repoService.getRepoList(input: RepoListInput())
                .map({ (output) -> [RepoModel] in
                    return output.repositories ?? []
                })
        }
        
        loadDataAction
            .elements
            .subscribe(onNext: { [weak self] (repoList) in
                self?.repoList.accept(repoList)
                self?.isLoadingData.accept(false)
            })
            .disposed(by: bag)
        
        loadDataAction
            .errors
            .subscribe(onError: { [weak self](error) in
                self?.isLoadingData.accept(false)
                print(error)
            })
            .disposed(by: bag)
    }

}
