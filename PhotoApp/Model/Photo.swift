//
//  Photo.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
