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
    private let dataManager: DataManager = DataManager()
    private var postCellModels: [PostCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Posts"
        configureTableView()
                
        dataManager.posts { posts in
            self.postCellModels = posts.map( { return PostCellModel(post: $0) }).sorted { $0.title < $1.title }
            self.tableView.reloadData()
        }
    }
    
    //  MARK: TableView Setup
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postView = PostViewController()
        postView.postViewModel = self.postCellModels[indexPath.row]
        navigationController?.pushViewController(postView, animated: false)
    }
    
    //  MARK: TableView Cell settings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.postCellModel = postCellModels[indexPath.row]
        return cell
    }
}
