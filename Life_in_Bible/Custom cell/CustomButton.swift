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
    
    
//    @IBInspectable
//    var barColor: UIColor = UIColor.systemBlue
    @IBInspectable
    var fillColor: UIColor = UIColor.init(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
    }
    
}

