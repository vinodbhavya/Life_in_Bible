//
//  BookTableViewCell.swift
//  Life_in_Bible
//
//  Created by rajasekharreddy.talamanchi on 28/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
