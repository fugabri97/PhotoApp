//
//  PostViewData.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation
import Alamofire

class PostViewData: PostViewModel {
    var post: Post
    var commentsCellModels: [CommentCellModel]?
    init(post: Post) {
        self.post = post
    }
    var onDidLoadData: (() -> Void)?
    var onDidFailLoadingData: ((_ errorMessage: String?) -> Void)?
    func load() {
        DataManager.shared.comments(postId: post.id) { (comments, error) in
            if error != nil {
                debugPrint(error!)
                self.onDidFailLoadingData?(error!)
                return
            }
            self.commentsCellModels = comments!.map({ return CommentCellModel(comment: $0) })
            self.onDidLoadData?()
        }
    }
}
