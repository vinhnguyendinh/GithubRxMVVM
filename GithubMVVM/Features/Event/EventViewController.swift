//
//  EventViewController.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventViewController: UIViewController {
    @IBOutlet weak var eventTableView: UITableView!
    
    fileprivate let bag = DisposeBag()
    fileprivate var navigator: Navigator!
    
    private var viewModel: EventViewModel!
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: EventViewModel) -> EventViewController {
        let controller = storyboard.instantiateViewController(ofType: EventViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.register(UINib(nibName: EventCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: EventCell.cellIdentifier)
        eventTableView.rowHeight = UITableView.automaticDimension
        eventTableView.estimatedRowHeight = 1000
        
        bindUI()
    }
    
    private func bindUI() {
        viewModel.repo
            .asObservable()
            .subscribe(onNext: { [weak self] (repo) in
                self?.title = repo.name
            })
            .disposed(by: bag)
        
        viewModel
            .eventList
            .asObservable()
            .bind(to: eventTableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath)
                self?.config(cell, at: indexPath)
                return cell
            }
            .disposed(by: bag)
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? EventCell {
            cell.event = viewModel.eventList.value[indexPath.row]
        }
    }

}
