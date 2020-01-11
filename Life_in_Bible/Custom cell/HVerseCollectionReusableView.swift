//
//  HVerseCollectionReusableView.swift
//  Life_in_Bible
//
//  Created by Bhavya on 11/01/20.
//  Copyright © 2020 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class HVerseCollectionReusableView: UICollectionReusableView {
    
    static var nibName : String
    {
        get { return "VerseHeader"}
    }
    
    static var reuseIdentifier: String
    {
        get { return "VerseHeaderCell"}
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
