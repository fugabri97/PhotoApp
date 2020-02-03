//
//  DataManager.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 20/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation
import Alamofire

class DataManager {
    
    public static let shared = DataManager()
    private let defaults = UserDefaults.standard
    
    // Creates the destination where the posts should be downloaded to
    private let destinationPostDownload: DownloadRequest.Destination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentsURL.appendingPathComponent("posts.txt")
        return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    // MARK: - Data requests
    public func posts(completionHandler: @escaping (_ posts: [Post]?, _ errorMessage: String?) -> Void) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentsURL.appendingPathComponent("posts.txt")
        
        // Looks for a existing posts file to load the data from
        let postsFile: Data? = FileManager.default.contents(atPath: fileUrl.path)
        
        if postsFile != nil && !isFileOutDated() {
            debugPrint("Load from file")
            completionHandler(parseJSONToPosts(postsFile!), nil)
        } else {
            // Does a Http request for the posts
            AF.download("https://jsonplaceholder.typicode.com/photos", to: destinationPostDownload).responseJSON { response in
                debugPrint("Load from get request")
                if let error = response.error {
                    debugPrint(error)
                } else {
                    if let jsonData = response.value {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: jsonData)
                            self.defaults.set(Date(), forKey: "LastUpdatedPosts")
                            completionHandler(self.parseJSONToPosts(data), nil)
                        } catch let error {
                            completionHandler(nil, "JSON serialization error: \(error)")
                            debugPrint("JSON serialization error: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    public func comments(postId: Int, completionHandler: @escaping (_ commenets: [Comment]?, _ errorMessage: String?) -> Void) {
        AF.request(
            "https://jsonplaceholder.typicode.com/photos/%7Bid%7D/comments?postId=\(postId)",
            method: .get
        ).responseJSON { response in
            if let error = response.error {
                debugPrint(error)
                completionHandler(nil, "Invalid response from the server")
                return
            } else {
                if let jsonData = response.value {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: jsonData)
                        let decodedComments = try JSONDecoder().decode([Comment].self, from: data)
                        completionHandler(decodedComments, nil)
                    } catch let error {
                        completionHandler(nil, "JSON serialization error: \(error)")
                        debugPrint("JSON serialization error: \(error)")
                    }
                }
            }
        }
    }
    
    // MARK: - File validation
    // Checks if the file data is too old
    private func isFileOutDated() -> Bool {
//        let lastTimePostsUpdated: Date? = self.defaults.object(forKey: "LastUpdatedPosts") as? Date
//        if let lastTime = lastTimePostsUpdated {
//            debugPrint("Last posts file is from: \(lastTime)")
//            if lastTime.distance(to: Date()) < 900 {
//                debugPrint("File still relevant")
//                return false
//            }
//        }
//        debugPrint("File unrelevant perform get request")
//        return true
        
        // Set to return true for debugging
        return true
    }
    //  TODO: - This function should be able to parse posts and comments
    // Parses json in to a array of posts
    private func parseJSONToPosts(_ dataFile: Data) -> [Post] {
        do {
            let posts = try JSONDecoder().decode([Post].self, from: dataFile)
            return posts
        } catch let jsonException {
            debugPrint(jsonException)
            return []
        }
    }
    
}
