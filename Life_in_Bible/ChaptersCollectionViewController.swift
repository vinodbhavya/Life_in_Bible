//
//  ChaptersCllectionCollectionViewController.swift
//  Life_in_Bible
//
//  Created by bhavya on 27/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk


class ChaptersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var chapterList: [DBTChapter] = []
    var bookId: String?
    var damId: String?
    private let reuseIdentifier = "ChapterCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChapters()
        
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    /*  @IBAction func chapterButton(_ sender: UIButton) {
     //perform action
     }*/
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 8, bottom: 0, right: 8)
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
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.imageView.tag = indexPath.row
        cell.imageView.isUserInteractionEnabled = true
        cell.imageView.addGestureRecognizer(tapGestureRecognizer)
        //        cell.imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 15 , y: 8, width: 30, height: 30))
        titleLabel.text = chapterList[indexPath.row].chapterId
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
        cell.imageView.addSubview(titleLabel)
        
        return cell
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let selectedChapter = chapterList[tappedImage.tag]
    
        print(selectedChapter)
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

//        guard let verseCV = mainStoryBoard.instantiateViewController(withIdentifier: "VerseTableViewController") as? VerseTableViewController else {
//        return
//        }

        guard let verseCV = mainStoryBoard.instantiateViewController(identifier: "VerseTableViewController") as? VerseTableViewController
            else {
            return
        }

        if let verseViewController = verseCV as? VerseTableViewController {
           verseViewController.damId = selectedChapter.damId
            verseViewController.bookId = selectedChapter.bookId
            verseViewController.chapterId = selectedChapter.chapterId as? NSNumber
        }
        
        /*
        print("beforePresent")
        print(verseCV.bookId as Any)
        print(verseCV.damId as Any)
        */
        
        navigationController?.pushViewController(verseCV, animated: true)
        
        // Your action
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
