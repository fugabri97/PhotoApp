//
//  PostListViewData.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 03/02/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

// TODO: - Set to class

import Foundation

class PostListViewData: PostListViewModel {
    var posts: [Post]?
    
    var postsViewModels: [PostViewData] = []
    var onDidLoadData: (() -> ())?
    var onDidFailLoadingData: ((_ errorMessage: String?) -> ())?
    
    func load() {
        DataManager.shared.posts() { (posts, error) in
            if error != nil {
                debugPrint(error!)
                self.onDidFailLoadingData?(error)
                return
            }
            self.postsViewModels = posts!.sorted(by: { $0.title < $1.title }).map({ return PostViewData(post: $0) })
            self.onDidLoadData?()
        }
    }
}
