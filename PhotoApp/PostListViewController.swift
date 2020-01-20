//
//  PostListViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout
import Alamofire

class PostListViewController: UIViewController {

    let tableView = UITableView.newAutoLayout()
    let label = UILabel.newAutoLayout()
    let dataManager: DataManager = DataManager()
    var posts: [Post] = []
    
    var lastDataLoadedTime: Date? = nil
    var isOutDatedData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Posts"
        configureTableView()
        dataManager.posts { posts in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    // MARK: TableView Setup
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        
        //  Set a identifier for the cell to reuse it
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.autoPinEdge(toSuperviewEdge: .top)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        
        let rightUIBarButton = UIBarButtonItem()
        rightUIBarButton.title = "Delete Posts file"
        self.navigationItem.rightBarButtonItem = rightUIBarButton
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
//  MARK: TableView Cell settings
extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.setCellPhoto(p: posts[indexPath.row])
        return cell
    }
    
}
