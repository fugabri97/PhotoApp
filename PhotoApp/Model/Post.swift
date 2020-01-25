//
//  Photo.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

struct Post: Decodable {
    public let id: Int
    public let albumId: Int
    public let title: String
    public let url: URL
    public let thumbnailUrl: URL
}
