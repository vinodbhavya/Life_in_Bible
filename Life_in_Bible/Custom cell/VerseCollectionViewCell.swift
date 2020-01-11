//
//  VerseCollectionViewCell.swift
//  Life_in_Bible
//
//  Created by Bhavya on 23/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class VerseCollectionViewCell: UICollectionViewCell {
    
    lazy var btn: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
        button.backgroundColor = .green
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width/2.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
