//
//  CanLoadFromRemote.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

protocol CanLoadFromRemote {
    // TODO: - onDidLoadData should return an array of posts or comments
    var onDidLoadData: ((Any) -> ())? { get set }
    var onDidFailLoadingData: ((_ errorMessage: String?) -> ())? { get set }
    
    func load()
}
