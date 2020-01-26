//
//  CanLoadFromRemote.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 23/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import Foundation

protocol CanLoadFromRemote {
    var onDidLoadData: ((Any) -> ())? { get set }
    var onDidFailLoadingData: ((Error) -> ())? { get set }
    
    func load()
}
