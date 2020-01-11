//
//  ViewController.swift
//  Life_in_Bible
//
//  Created by bhavya on 27/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk

class ViewController: UIViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "OldTestamentSegue") {
            if let viewcontroller = segue.destination as? BooksTableViewController {
                viewcontroller.damId = AppConstants.otTextDamId
                
            }
        } else if(segue.identifier == "NewTestamentSegue") {
            if let viewcontroller = segue.destination as? BooksTableViewController {
                viewcontroller.damId = AppConstants.ntTextDamId
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
