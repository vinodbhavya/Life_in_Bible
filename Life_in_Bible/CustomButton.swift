//
//  CustomButton.swift
//  Life_in_Bible
//
//  Created by Bhavya on 11/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
   
    @IBInspectable
   var barColor: UIColor = UIColor.systemBlue
    @IBInspectable
    var fillColor: UIColor = UIColor.green

    override func draw(_ rect: CGRect) {
    let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
    path.fill()
    }
    
    
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

