//
//  PostListViewData.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 03/02/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

struct PostListViewData: PostListViewModel {
    var posts: [Post]?
    var onDidLoadData: ((Any) -> ())?
    var onDidFailLoadingData: ((_ errorMessage: String?) -> ())?
    
    func load() {
        DataManager.shared.posts() { (posts, error) in
            if error != nil {
                debugPrint(error!)
                self.onDidFailLoadingData?(error)
                return
            }
            self.onDidFailLoadingData?(error)
            self.onDidLoadData?(posts as Any)
        }
    }
}
