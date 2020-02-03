//
//  PostsViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout

class PostListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView.newAutoLayout()
    private let label = UILabel.newAutoLayout()
    private var postListViewData = PostListViewData()
    private let loadingIndicatorView = UIActivityIndicatorView.newAutoLayout()
    private var postViewModels: [PostViewData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Posts"
        configureTableView()
        configureLoadingIndicatorView()
        postListViewData.onDidFailLoadingData = { error in
            let alert = UIAlertController(title: "Could not fetch posts", message: "TEST!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        postListViewData.onDidLoadData = { posts in
            debugPrint(posts)
            let postArray = posts as! [Post]
            self.postViewModels = postArray.map({ return PostViewData(post: $0) })
            self.loadingIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
        postListViewData.load()
    }
    private func configureLoadingIndicatorView() {
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.style = .large
        loadingIndicatorView.color = .systemGray
        loadingIndicatorView.autoAlignAxis(.horizontal, toSameAxisOf: view)
        loadingIndicatorView.autoAlignAxis(.vertical, toSameAxisOf: view)
        loadingIndicatorView.startAnimating()
    }
    // MARK: - TableView Setup
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        //  Set a identifier for the cell to reuse it
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.autoPinEdge(toSuperviewEdge: .top)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
    }
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postView = PostViewController()
        postView.postViewModel = self.postViewModels[indexPath.row]
        navigationController?.pushViewController(postView, animated: true)
    }
    // MARK: - TableView Cell settings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell // swiftlint:disable:this force_cast
        cell.postViewModel = postViewModels[indexPath.row]
        return cell
    }
}
