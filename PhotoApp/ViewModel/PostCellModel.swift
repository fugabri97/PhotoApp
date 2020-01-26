//
//  PostCellModel.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

class PostCellModel {
    var title: String
    var thumbnailUrl: URL
    
    init(post: Post) {
        title = post.title
        thumbnailUrl = post.thumbnailUrl
    }
}
