//
//  CommentCell.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 26/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

// TODO: Remove public

import UIKit

class CommentCell: UITableViewCell {
    private let emailLabel: UILabel = UILabel()
    private let commentLabel: UILabel = UILabel()
    
    var commentCellModel: CommentCellModel! {
        didSet {
            emailLabel.text = "\(commentCellModel.comment.email):"
            commentLabel.text = commentCellModel.comment.body
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(emailLabel)
        addSubview(commentLabel)
        emailLabelSetup()
        commentLabelSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func emailLabelSetup() {
        emailLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.autoPinEdge(.top, to: .top, of: self)
        emailLabel.autoPinEdge(.leading, to: .leading, of: self)
        emailLabel.autoPinEdge(.trailing, to: .trailing, of: self)
    }
    
    private func commentLabelSetup() {
        commentLabel.font = UIFont.preferredFont(forTextStyle: .body)
        commentLabel.adjustsFontSizeToFitWidth = false
        commentLabel.lineBreakMode = .byTruncatingTail
        commentLabel.numberOfLines = 0
        commentLabel.autoPinEdge(.top, to: .bottom, of: emailLabel)
        commentLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 20)
        commentLabel.autoPinEdge(.trailing, to: .trailing, of: self)
        commentLabel.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -20)
    }
}
