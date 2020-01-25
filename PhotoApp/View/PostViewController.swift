//
//  PostViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    private var comments: [Comment] = []
    
    public var postViewModel: PostViewData! {
        didSet {
            debugPrint("Test")
            self.postViewModel.load(postId: 1)
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
    }

}
