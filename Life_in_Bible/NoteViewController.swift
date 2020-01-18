//
//  NoteViewController.swift
//  Life_in_Bible
//
//  Created by Mohammad Saiful Kabir on 18/01/2020.
//  Copyright © 2020 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = ["Wake up early", "Go to church"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let name = UserDefaults.standard.value(forKey: "name") as? String ?? ""
        self.list.append(name)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Add a Note", preferredStyle: .alert)
        alert.addTextField { (textField) in
         textField.isUserInteractionEnabled = true
        }
         
         alert.addAction(UIAlertAction(title: "Add", style: .default) { (action) in
             let newAdd = alert.textFields![0]
             self.list.append(newAdd.text!)
             self.myTableView.reloadData()
            
            UserDefaults.standard.set(newAdd.text!, forKey: "name" )
         })
         
         alert.addAction(UIAlertAction(title: "Cancel", style: .default))
         
         self.present(alert, animated: true, completion: nil)
         
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
}
