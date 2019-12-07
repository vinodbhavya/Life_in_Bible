//
//  ChaptersCllectionCollectionViewController.swift
//  Life_in_Bible
//
//  Created by rajasekharreddy.talamanchi on 27/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk


class ChaptersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
   var chapterList: [DBTChapter] = []
    var bookId: String?
    var damId: String?
    private let reuseIdentifier = "ChapterCell"
    private let itemsPerRow: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 25.0, left: 20.0, bottom: 25.0, right: 20.0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getChapters()

        }
        
        

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterList.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChapterCollectionViewCell
        
        let titleLabel = UILabel(frame: CGRect(x: 8 , y: 0, width: 30, height: 30))
        titleLabel.text = chapterList[indexPath.row].chapterId
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
        cell.imageView.addSubview(titleLabel)
        
//        cell.chapterName.text = chapters[indexPath.row].chapterId
               
        return cell
    }

    
    
    func getChapters() {
       
     [DBT .getLibraryChapter(withDamId: self.damId, bookId: self.bookId, success: {(chapterList) in
           
            
        self.chapterList = chapterList as! [DBTChapter]
                      self.collectionView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })]
    }
    

    
    // Configure the cell
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
