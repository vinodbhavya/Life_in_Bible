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
    var bookId = "Gen"
    var chapterId = NSNumber(1)
    var selectedVerse: DBTVerse?
    var verseId: String?
    var damId = "ENGESVO2ET"
    
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
   
        let titleLabel = UILabel(frame: CGRect(x: 16 , y: 12, width: 25, height: 25))
//        titleLabel.text = verseList[indexPath.row].verseId
//               titleLabel.text = chapterList[indexPath.row].chapterId
               titleLabel.textColor = UIColor.black
               titleLabel.font = UIFont(name:"chalkboard SE", size: 19)
        cell.verseImageView.addSubview(titleLabel)
//               cell.chapterButton.addSubview(titleLabel)
        
        return cell
        
    }
    
    
    func getVerses() {
        
        
        
        [DBT .getTextVerse(withDamId: damId, book: bookId, chapter: chapterId, verseStart: 1 as NSNumber, verseEnd: 200 as NSNumber, success: {(verseList) in
            
            print(verseList as Any)
                       self.verseList = verseList as! [DBTVerse]
                        self.tableView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })]
        
    }
   
}
