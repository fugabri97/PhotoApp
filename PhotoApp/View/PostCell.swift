//
//  PostCell.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout

class PostCell: UITableViewCell {
    private var thumbnailImageView = UIImageView.newAutoLayout()
    private var thumbnailTitleLabel = UILabel.newAutoLayout()
    
    public var postCellModel: PostCellModel! {
        didSet {
            do {
                let imageData = try Data(contentsOf: postCellModel.thumbnailUrl)
                let image = UIImage(data: imageData)
                thumbnailImageView.image = image
            } catch let error {
                debugPrint("Error getting contents of the thumbnailUrl \(error)")
            }
            thumbnailTitleLabel.text = postCellModel.title
        }
    }
    
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
    
    private func configureThumbnailImageView() {
        thumbnailImageView.layer.cornerRadius = 5
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.autoAlignAxis(.horizontal, toSameAxisOf: self)
        thumbnailImageView.autoSetDimension(.height, toSize: 80)
        thumbnailImageView.autoSetDimension(.width, toSize: 80, relation: .equal)
        thumbnailImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 20)
    }
    
    private func configureThumbnailTitleLabel() {
        thumbnailTitleLabel.numberOfLines = 0
        thumbnailTitleLabel.adjustsFontSizeToFitWidth = true
        thumbnailTitleLabel.autoAlignAxis(.horizontal, toSameAxisOf: self)
        thumbnailTitleLabel.autoPinEdge(.leading, to: .trailing, of: thumbnailImageView, withOffset: 20)
        thumbnailTitleLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 20)
        thumbnailTitleLabel.autoSetDimension(.height, toSize: 80)
    }
}
