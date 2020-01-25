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
    var post: Post?
    var comments: [Comment]?
    
    var onDidLoadData: (() -> ())?
    var onDidFailLoadingData: (() -> ())?
    
    func load(postId: Int) {
        debugPrint("Test")
        AF.request("jsonplaceholde.typicode.com/photo/%7Bid%7D/comments?postId=\(postId)").response { response in
            debugPrint(response.value!)
        }
    }
}
