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
    
    private let defaults = UserDefaults.standard
    
    //  Creates the destination where the posts should be downloaded to
    private let destinationPostDownload: DownloadRequest.Destination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentsURL.appendingPathComponent("posts.txt")
        return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    //  MARK: Loading posts data form file or internet
    public func posts(completionHandle: @escaping (_ posts: [Post]) -> ()) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentsURL.appendingPathComponent("posts.txt")
        
        //  Looks for a existing posts file to load the data from
        let postsFile: Data? = FileManager.default.contents(atPath: fileUrl.path)
        
        if postsFile != nil && !isFileOutDated() {
            debugPrint("Load from file")
            completionHandle(parseJSONToPosts(postsFile!))
        } else {
            //  Does a Http request for the posts
            AF.download("https://jsonplaceholder.typicode.com/photos", to: destinationPostDownload).responseJSON { response in
                debugPrint("Load from get request")
                if let error = response.error {
                    debugPrint(error)
                } else {
                    if let jsonData = response.value {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: jsonData)
                            self.defaults.set(Date(), forKey: "LastUpdatedPosts")
                            completionHandle(self.parseJSONToPosts(data))
                        } catch let error {
                            debugPrint("JSON error: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    //  Checks if the file data is too old
    private func isFileOutDated() -> Bool {
        let lastTimePostsUpdated: Date? = self.defaults.object(forKey: "LastUpdatedPosts") as? Date
        if let lastTime = lastTimePostsUpdated {
            debugPrint("Last posts file is from: \(lastTime)")
            if lastTime.distance(to: Date()) < 900 {
                debugPrint("File still relevant")
                return false
            }
        }
        debugPrint("File unrelevant perform get request")
        return true
    }
    
    //  Parses json in to a array of posts
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
