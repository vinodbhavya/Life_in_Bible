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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        getVerses()
        super.viewDidLoad()
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
        
       
        
        if (selectedVerse?.verseId === self.verseList[indexPath.row].verseId){
            cell.contentView.backgroundColor = UIColor.gray
            
        }
        
        
        
        cell.verseText.text = verseList[indexPath.row].verseText
        
        let titleLabel = UILabel(frame: CGRect(x: 16 , y: 12, width: 25, height: 25))
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 19)
        cell.verseImageView.addSubview(titleLabel)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.gray
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white
    }
    
    func getVerses() {
        
        
        DBT .getTextVerse(withDamId: damId, book: bookId, chapter: chapterId, verseStart: 1 as NSNumber, verseEnd: 200 as NSNumber, success: {(verseList) in
            
            self.verseList = verseList as! [DBTVerse]
            self.tableView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })
        
    }
    
}
