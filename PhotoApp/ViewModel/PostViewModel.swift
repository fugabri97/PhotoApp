//
//  PostViewModel.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 20/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

protocol PostViewModel: CanLoadFromRemote {
    var post: Post? { get }
    var comments: [Comment]? { get }
}
