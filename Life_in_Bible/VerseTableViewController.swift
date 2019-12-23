//
//  VerseTableViewController.swift
//  Life_in_Bible
//
//  Created by Bhavya on 15/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk

class VerseTableViewController: UITableViewController {
    
    var verseList: [DBTVerse] = []
    var bookId: String?
    var chapterId: NSNumber?
    
    
    var damId: String?
    
    private let reuseIdentifier = "VerseCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVerses()
       
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? VerseTableViewCell else {
            fatalError("The dequeued cell is not an instance of VerseTableViewCell.")
        }
        
        

        
       
        cell.verseText.text = verseList[indexPath.row].verseText
        
//        cell.verseText.isScrollEnabled = false
//        cell.verseText.isEditable = false
        
//        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
//        cell.verseText.text = verseList[indexPath.row].verseText
//        cell.verseText.lineBreakMode = NSLineBreakMode.byWordWrapping
//        cell.verseText.sizeToFit()
        
        
        return cell
        
    }
    
    
    func getVerses() {
        
        
        
        [DBT .getTextVerse(withDamId: damId, book: bookId, chapter: chapterId, verseStart: 1 as! NSNumber, verseEnd: 50 as! NSNumber, success: {(verseList) in
            
            print(verseList as Any)
                       self.verseList = verseList as! [DBTVerse]
                        self.tableView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })]
        
    }
   
}
