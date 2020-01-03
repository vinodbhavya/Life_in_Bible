//
//  VerseCollectionViewCell.swift
//  Life_in_Bible
//
//  Created by Bhavya on 23/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class VerseCollectionViewCell: UICollectionViewCell {
    
  var bg: UIImageView = {
    let iv = UIImageView(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.isUserInteractionEnabled = true
    iv.contentMode = .scaleAspectFill
    return iv
    }()

    override init(frame: CGRect) {
    super.init(frame: .zero)
    contentView.addSubview(bg)


    }

    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}
