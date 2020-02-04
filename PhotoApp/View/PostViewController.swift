//
//  PostViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let imageView: UIImageView = UIImageView.newAutoLayout()
    private let commenstTableView: UITableView = UITableView.newAutoLayout()
    private var commentCellModels: [CommentCellModel] = []
    public var postViewData: PostViewData! {
        didSet {
            do {
                let imageData = try Data(contentsOf: postViewData.post.url)
                let image = UIImage.init(data: imageData)
                imageView.image = image
            } catch let error {
                debugPrint(error)
            }
            title = postViewData.post.title
            // TODO: - Do the casting in the ViewModel
            postViewData.onDidLoadData = {
                self.commentCellModels = self.postViewData.commentsCellModels!
                self.commenstTableView.reloadData()
            }
            self.postViewData.load()
        }
    }
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imageViewSetup()
        commenstTableViewSetUp()
    }
    // MARK: - UI setup
    private func imageViewSetup() {
        view.addSubview(imageView)
        imageView.autoPinEdge(.leading, to: .leading, of: view)
        imageView.autoPinEdge(.trailing, to: .trailing, of: view)
        imageView.autoPinEdge(toSuperviewSafeArea: .top)
        imageView.autoSetDimension(.height, toSize: 400)
    }
    private func commenstTableViewSetUp() {
        view.addSubview(commenstTableView)
        commenstTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        commenstTableView.separatorStyle = .none
        commenstTableView.delegate = self
        commenstTableView.dataSource = self
        commenstTableView.estimatedRowHeight = 50
        commenstTableView.rowHeight = UITableView.automaticDimension
        commenstTableView.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 20)
        commenstTableView.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        commenstTableView.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        commenstTableView.autoPinEdge(toSuperviewSafeArea: .bottom)

    }
    // MARK: - Comments tableView cells setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentCellModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        cell.commentCellModel = commentCellModels[indexPath.row]
        return cell
    }
}
