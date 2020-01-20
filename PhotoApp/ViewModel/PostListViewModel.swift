//
//  PostListViewModel.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 20/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

struct PostViewModel {
    
    let title: String
    let thumbnailUrl: URL
    
    init(post: Post) {
        self.title = post.title
        self.thumbnailUrl = post.thumbnailUrl
    }
}
