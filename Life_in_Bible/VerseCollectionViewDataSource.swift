//
//  VerseCollectionViewDataSource.swift
//  Life_in_Bible
//
//  Created by Bhavya on 28/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk



class VerseCollectionViewDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var verseList: [DBTVerse] = []
//    private let navigationController: UINavigationController
    
    init(_ verses: [DBTVerse]) {
        self.verseList = verses
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CGSize(width: 70, height: 70)
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return verseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerseCell", for: indexPath) as? VerseCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.bg.isUserInteractionEnabled = true
        cell.bg.addGestureRecognizer(tapGestureRecognizer)
        cell.bg.tag = indexPath.row
        
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 7.5, width: 30, height: 30))
        let text = self.verseList[indexPath.row].verseId!
        titleLabel.text = (text as! String)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
        cell.bg.image = #imageLiteral(resourceName: "tab")
        cell.bg.addSubview(titleLabel)
        
        
        return cell
        
    }
    
    
    
   @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
      {
          let tappedImage = tapGestureRecognizer.view as! UIImageView

          let selectedVerse = self.verseList[tappedImage.tag]

      let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

             guard let verseCV = mainStoryBoard.instantiateViewController(identifier: "VerseTableViewController") as? VerseTableViewController else {
                 return
             }

             if let verseViewController = verseCV as? VerseTableViewController {

                 verseViewController.selectedVerse = selectedVerse
             }

//       let window = UIApplication.shared.keyWindow
        

        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        let chapterCV = ChaptersCollectionViewController.init(collectionViewLayout: layout)
        chapterCV.navigateToVerseCV(selectedVerse: selectedVerse)
        
//    let navigationCV = UINavigationController(rootViewController: chapterCV)
////        window?.rootViewController = navigationCV
//        window?.makeKeyAndVisible()
//        navigationCV.present(verseCV, animated: true, completion: nil)
//
    }
    
    
}




