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
    
    var onDidLoadData: ((Any) -> ())?
    var onDidFailLoadingData: ((Error) -> ())?

    func load() {
        AF.request("https://jsonplaceholder.typicode.com/photos/%7Bid%7D/comments?postId=\(post.id)", method: .get).responseJSON { response in
            if let error = response.error {
                debugPrint(error)
                self.onDidFailLoadingData?(error)
                return
            } else {
                if let jsonData = response.value {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: jsonData)
                        let decoded = try JSONDecoder().decode([Comment].self, from: data)
                        self.onDidLoadData?(decoded as [Comment])
                    } catch let error {
                        debugPrint("JSON serialization error: \(error)")
                    }
                }
            }
        }
    }
}
