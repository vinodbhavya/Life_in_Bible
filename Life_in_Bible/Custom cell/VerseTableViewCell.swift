//
//  VerseTableViewCell.swift
//  Life_in_Bible
//
//  Created by Bhavya on 15/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class VerseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var verseImageView: UIImageView!
    
    @IBOutlet weak var verseText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
