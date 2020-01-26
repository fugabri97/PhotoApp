//
//  CommentCell.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 26/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    private let emailLabel: UILabel = UILabel.newAutoLayout()
    private let commentLabel: UILabel = UILabel.newAutoLayout()
    
    public var commentCellModel: CommentCellModel! {
        didSet {
            debugPrint(commentCellModel.comment.email)
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
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.autoPinEdge(toSuperviewMargin: .leading, withInset: 2)
        emailLabel.autoPinEdge(.top, to: .top, of: self)
        emailLabel.autoPinEdge(.trailing, to: .trailing, of: self)
        emailLabel.autoPinEdge(.bottom, to: .top, of: commentLabel)
    }
    
    private func commentLabelSetup() {
        commentLabel.adjustsFontSizeToFitWidth = false
        commentLabel.numberOfLines = .bitWidth
        commentLabel.autoPinEdge(toSuperviewMargin: .leading, withInset: 10)
        commentLabel.autoPinEdge(.top, to: .bottom, of: emailLabel)
        commentLabel.autoPinEdge(.trailing, to: .trailing, of: self)
//        commentLabel.autoPinEdge(.leading, to: .leading, of: self)
        commentLabel.autoPinEdge(.bottom, to: .bottom, of: self)
    }
}
