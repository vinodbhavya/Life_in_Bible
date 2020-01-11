//
//  VerseCollectionViewDataSource.swift
//  Life_in_Bible
//
//  Created by Bhavya on 28/12/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk

class VerseCollectionViewDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var verseList: [DBTVerse] = []
    weak var verseDelegate:VerseCollectionViewDelegate?
    
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
    
    //Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
    
    
    //Header Cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HVerseCollectionReusableView.reuseIdentifier, for: indexPath) as! HVerseCollectionReusableView
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 75))
            titleLabel.text = "Select Verse"
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name:"chalkboard SE", size: 18)
            titleLabel.textAlignment = .center
            titleLabel.backgroundColor = UIColor.init(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
            
            headerView.addSubview(titleLabel)
            return headerView
        }
        fatalError()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerseCell", for: indexPath) as? VerseCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        cell.btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        let text = self.verseList[indexPath.row].verseId!
        cell.btn.setTitle((text as! String), for: .normal)
        cell.btn.tag = indexPath.row
        
        return cell
        
    }
    
    @objc func buttonTapped(_ sender: UIButton)
    {
        let selectedVerse = self.verseList[sender.tag]
        verseDelegate?.userDidTap(into: selectedVerse)
    }
    
}

protocol VerseCollectionViewDelegate: class {
    func userDidTap(into selectedVerse: DBTVerse)
}


