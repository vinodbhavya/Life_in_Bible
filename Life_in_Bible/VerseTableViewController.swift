//
//  VerseTableViewController.swift
//  Life_in_Bible
//
//  Created by Bhavya on 15/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk
import Foundation

class VerseTableViewController: UITableViewController {
    
    var verseList: [DBTVerse] = []
    var damId: String?
    var selectedVerse: DBTVerse?
    
    
    private let reuseIdentifier = "VerseCell"
    
    override func viewDidLoad() {
        getVerses()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let verseId = selectedVerse!.verseId
        let verseIndex:Int? = (verseId != nil) ? Int(verseId!) : nil
        let index: Int = verseIndex! > 0 ? verseIndex! - 1 : 0
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        
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
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        titleLabel.textAlignment = .center
        let text = self.verseList[indexPath.row].verseId!
        titleLabel.text = (text as! String)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
        cell.verseImageView.addSubview(titleLabel)
        
        return cell
        
    }
    
    func getVerses() {
        
        DBT .getTextVerse(withDamId: damId, book: selectedVerse?.bookId, chapter: selectedVerse?.chapterId, verseStart: 1 as NSNumber, verseEnd: 200 as NSNumber, success: {(verseList) in
            
            self.verseList = verseList as! [DBTVerse]
            self.tableView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })
        
    }
    
}
