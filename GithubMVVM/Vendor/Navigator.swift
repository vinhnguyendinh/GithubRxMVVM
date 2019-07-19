//
//  Navigator.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import RxSwift
import Swinject
import SwinjectStoryboard
import RxCocoa

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - Segues list
    enum Segue {
        case repoList
        case eventList(repo: BehaviorRelay<RepoModel>)
    }
    
    // MARK: - Invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .repoList:
            let viewModel = RepoViewModel(repoService: SwinjectStoryboard.defaultContainer.resolve(RepoServiceProtocol.self)!)
            show(target: RepoViewController.createWith(navigator: self,
                                                       storyboard: defaultStoryboard,
                                                       viewModel: viewModel),
                 sender: sender)
            break
            
        case .eventList(let repo):
            let viewModel = EventViewModel(eventService: SwinjectStoryboard.defaultContainer.resolve(EventServiceProtocol.self)!,
                                           repo: repo)
            show(target: EventViewController.createWith(navigator: self,
                                                        storyboard: defaultStoryboard,
                                                        viewModel: viewModel),
                 sender: sender)
            break
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
        } else if let nav = sender.navigationController {
            nav.pushViewController(target, animated: true)
        }
    }
    
    private func present(target: UIViewController, sender: UIViewController) {
        sender.present(target, animated: true, completion: nil)
    }
}
