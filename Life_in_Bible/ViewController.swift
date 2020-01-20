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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !Reachability.isConnectedToNetwork() {
            self.alert(message: "No Internet Connection", title: "Network")
        }
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
    func alert(message: String, title: String = "") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
            switch action.style {
            case .default:
                self.openSettings()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                self.openSettings()
            }}
        ))
        present(alertController, animated: true, completion: nil)
    }
    
    func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, completionHandler: nil)
    }
}
