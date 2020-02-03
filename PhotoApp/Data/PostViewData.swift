//
//  PostViewData.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation
import Alamofire

struct PostViewData: PostViewModel {
    var post: Post
    var comments: [Comment]?
    init(post: Post) {
        self.post = post
    }
    var onDidLoadData: ((Any) -> Void)?
    var onDidFailLoadingData: ((_ errorMessage: String?) -> Void)?
    func load() {
        DataManager.shared.comments(postId: post.id) { (comments, error) in
            if error != nil {
                debugPrint(error!)
                self.onDidFailLoadingData?(error!)
                return
            }
            self.onDidLoadData?(comments as Any)
        }
    }
}
