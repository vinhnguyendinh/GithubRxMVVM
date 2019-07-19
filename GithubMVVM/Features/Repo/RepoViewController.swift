//
//  RepoViewController.swift
//  GithubMVVM
//
//  Created by Vinh on 7/19/19.
//  Copyright © 2019 GCS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoViewController: UIViewController {
    // MARK: - UI Properties
    @IBOutlet weak var repoTableView: UITableView!
    private var refreshControl: UIRefreshControl!

    // MARK: - Properties
    
    // View model
    var viewModel: RepoViewModel!
    
    // Bag
    fileprivate let bag = DisposeBag()
    
    // Navigator
    fileprivate var navigator: Navigator!


    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    // MARK: - Config
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: RepoViewModel) -> RepoViewController {
        let controller = storyboard.instantiateViewController(ofType: RepoViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        
        return controller
    }
    
    func initViews() {
        setupNav()
        setupTableView()
        setupRefresh()
        
        bindUI()
        loadAction()
    }
    
    func setupNav() {
        self.title = "Repo List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    }
    
    func setupTableView() {
        repoTableView.dataSource = self
        repoTableView.delegate = self
        repoTableView.tableFooterView = UIView()
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.register(UINib(nibName: RepoCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: RepoCell.cellIdentifier)
    }
    
    func setupRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        repoTableView.addSubview(refreshControl)
    }
    
    // MARK: - UI Actions
    
    // MARK: - Handler
    func bindUI() {
        self.navigationItem.rightBarButtonItem!.rx
            .bind(to: viewModel.loadDataAction) { _ in return "Refresh button" }
        
        viewModel.isLoadingData
            .subscribe(onNext: { [weak self] isLoadingData in
                guard let `self` = self else { return }
                
                if isLoadingData {
                    self.refreshControl.beginRefreshing()
                } else {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: bag)
        
        viewModel.repoList
            .subscribe(onNext: { [weak self] (repos) in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    self.repoTableView.reloadData()
                }
            })
            .disposed(by: bag)
        
        refreshControl.rx
            .bind(to: viewModel.loadDataAction, controlEvent: refreshControl.rx.controlEvent(.valueChanged)) { _ in
                return "Refresh button"
        }
    }
    
    func loadAction() {
        viewModel.loadDataAction.execute("First load")
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? RepoCell {
            cell.repo = viewModel.repoList.value[indexPath.row]
        }
    }
    
    // MARK: - Notifications
    
    // MARK: - Utils
}

// MARK: - UITableViewDataSource
extension RepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.cellIdentifier, for: indexPath)
        
        if let repoCell = cell as? RepoCell {
            repoCell.repo = viewModel.repoList.value[indexPath.row]
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RepoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repo = viewModel.repoList.value[indexPath.row]
        self.navigator.show(segue: .eventList(repo: BehaviorRelay(value: repo)), sender: self)
    }
}
