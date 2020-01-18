//
//  MenuViewController.swift
//  Life_in_Bible
//
//  Created by Mohammad Saiful Kabir on 18/01/2020.
//  Copyright © 2020 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var lists = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact))
    }
    

    @objc func handleAddContact() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
            let activity = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            self.present(activity, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Notes", style: .default, handler: { (action) in
            
            self.performSegue(withIdentifier: "passData", sender: self)
            func prepare(for segue: UIStoryboard, sender: Any?) {
                let VC = segue.description as! NoteViewController
                VC.list = self.lists
            }
            
        }))  
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        self.present(alert, animated: true)
        
    }

}
