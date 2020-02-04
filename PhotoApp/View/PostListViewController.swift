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
    private var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Posts"
        configureBarItems()
        configureTableView()
        configureLoadingIndicatorView()
        postListViewData.onDidFailLoadingData = { error in
            self.loadingIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
            let alert = UIAlertController(title: "Could not fetch posts", message: "TEST!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            debugPrint("Failed to load data")
        }
        postListViewData.onDidLoadData = {
            self.refreshControl.endRefreshing()
            self.postViewModels = self.postListViewData.postsViewModels
            self.loadingIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
        postListViewData.load()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    @objc private func handleRefresh() {
        debugPrint("Refresh")
        postListViewData.load()
    }
    private func configureBarItems() {
        let deletePostsFileBarButtonItem = UIBarButtonItem(title: "Delete Local File", style: .plain, target: self, action: #selector(deleteLocalDataFile))
        navigationItem.rightBarButtonItem = deletePostsFileBarButtonItem
    }
    // This method deletes the local file with posts
    // and sends a new requests for the posts
    @objc func deleteLocalDataFile() {
        DataManager.shared.deleteLocalPostsFile()
        postListViewData.load()
        postViewModels = []
        tableView.reloadData()
        loadingIndicatorView.startAnimating()
    }
    // MARK: - Loading indicator setup
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
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.autoPinEdge(toSuperviewEdge: .top)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
    }
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postView = PostViewController()
        postView.postViewData = self.postViewModels[indexPath.row]
        navigationController?.pushViewController(postView, animated: true)
    }
    // MARK: - TableView Cell setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.postViewModel = postViewModels[indexPath.row]
        return cell
    }
}
