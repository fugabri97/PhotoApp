//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout

class PhotoCell: UITableViewCell {
    
    var thumbnailImageView = UIImageView.newAutoLayout()
    var thumbnailTitleLabel = UILabel.newAutoLayout()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnailImageView)
        addSubview(thumbnailTitleLabel)
        
        configureThumbnailImageView()
        configureThumbnailTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureThumbnailImageView() {
        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.backgroundColor = .lightGray
                
        thumbnailImageView.autoAlignAxis(.horizontal, toSameAxisOf: self)
        thumbnailImageView.autoSetDimension(.height, toSize: 80)
        thumbnailImageView.autoSetDimension(.width, toSize: 80 * 16/9, relation: .equal)
        thumbnailImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 20)
    }
    
    func configureThumbnailTitleLabel() {
        thumbnailTitleLabel.numberOfLines = 0
        thumbnailTitleLabel.adjustsFontSizeToFitWidth = true
        thumbnailTitleLabel.text = "Test Label"
        
        thumbnailTitleLabel.autoAlignAxis(.horizontal, toSameAxisOf: self)
        thumbnailTitleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 20)
        thumbnailTitleLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 20)
        thumbnailTitleLabel.autoSetDimension(.height, toSize: 80)
    }

}
