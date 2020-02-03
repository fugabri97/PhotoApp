//
//  PostViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let imageView: UIImageView = UIImageView.newAutoLayout()
    private let titleLabel: UILabel = UILabel.newAutoLayout()
    private let commenstTableView: UITableView = UITableView.newAutoLayout()
    private var commentModels: [CommentCellModel] = []
    public var postViewModel: PostViewData! {
        didSet {
            do {
                let imageData = try Data(contentsOf: postViewModel.post.url)
                let image = UIImage.init(data: imageData)
                imageView.image = image
            } catch let error {
                debugPrint(error)
            }
            titleLabel.text = postViewModel.post.title
            postViewModel.onDidLoadData = { comments in
                let commentArray: [Comment] = comments as! [Comment]
                self.commentModels = commentArray.map({ return CommentCellModel(comment: $0) })
                self.commenstTableView.reloadData()
            }
            self.postViewModel.load()
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
        view.backgroundColor = .white
        imageViewSetup()
        titleLabelSetup()
        commenstTableViewSetUp()
    }
    private func imageViewSetup() {
        view.addSubview(imageView)
        imageView.autoPinEdge(.leading, to: .leading, of: view)
        imageView.autoPinEdge(.trailing, to: .trailing, of: view)
        imageView.autoPinEdge(toSuperviewSafeArea: .top)
        imageView.autoSetDimension(.height, toSize: 400)
        imageView.backgroundColor = .red
    }
    private func titleLabelSetup() {
        view.addSubview(titleLabel)
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: view)
        titleLabel.autoPinEdge(.leading, to: .leading, of: view)
        titleLabel.autoSetDimension(.height, toSize: 50)
    }
    private func commenstTableViewSetUp() {
        view.addSubview(commenstTableView)
        commenstTableView.autoPinEdge(.top, to: .bottom, of: titleLabel)
        commenstTableView.autoPinEdge(.leading, to: .leading, of: view)
        commenstTableView.autoPinEdge(.trailing, to: .trailing, of: view)
        commenstTableView.autoPinEdge(toSuperviewEdge: .bottom)
        commenstTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        commenstTableView.separatorStyle = .none
        commenstTableView.delegate = self
        commenstTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentCell
        cell?.commentCellModel = commentModels[indexPath.row]
        return cell!
    }
}
