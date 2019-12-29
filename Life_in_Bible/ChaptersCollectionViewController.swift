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
    var verseList: [DBTVerse] = []
    var bookId: String?
    var damId: String?
    var transparentView = UIView()
    var verseCollectionViewDataSource: VerseCollectionViewDataSource?
    
    
    
    
    private let reuseIdentifier = "ChapterCell"
    private let semaphore = DispatchSemaphore(value: 0)
    private let queue = DispatchQueue.global()
    
    var collectionViewHeight: CGFloat = 9 * 50
    
    
    
    let verseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(VerseCollectionViewCell.self, forCellWithReuseIdentifier: "VerseCell")
        cv.backgroundColor = .white
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getChapters()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chapterList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CGSize(width: 70, height: 70)
        
        return cell
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChapterCollectionViewCell
        
        
        cell.chapterButton.tag = indexPath.row
        cell.chapterButton.isUserInteractionEnabled = true
        
        cell.chapterButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        
        
        //        Note: we need to calculate left margin(x) label dynamically
        //        1. find the length of character
        //        2. to calculate left margin based on length
        
        let titleLabel = UILabel(frame: CGRect(x: 16 , y: 12, width: 25, height: 25))
        titleLabel.text = chapterList[indexPath.row].chapterId
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 19)
        cell.chapterButton.addSubview(titleLabel)
        
        
        return cell
        
    }
    
    
    @objc func buttonTapped(_ sender: CustomButton)
    {
        
        let selectedChapter = chapterList[sender.tag]
        print(selectedChapter)
        
        getVerseText(damId: selectedChapter.damId, bookId: selectedChapter.bookId, NumberFormatter().number(from: selectedChapter.chapterId)!, completion: { [weak self] (list) in
            
            self?.verseCollectionViewDataSource = VerseCollectionViewDataSource(list)
            self?.verseCollectionView.delegate = self?.verseCollectionViewDataSource
            self?.verseCollectionView.dataSource = self?.verseCollectionViewDataSource
            
            self?.verseCollectionView.reloadData()
            
        })
        
        
        
        
        
        
        
        
        
        
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        transparentView.alpha = 0
        window?.addSubview(transparentView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransperentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        let screenSize = UIScreen.main.bounds.size
        //        verseCollectionView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: collectionViewHeight)
        window?.addSubview(verseCollectionView)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0, options: .curveEaseInOut,
                       animations: {
                        self.transparentView.alpha = 0.5
                        self.verseCollectionView.frame = CGRect(x: 0, y: screenSize.height - self.collectionViewHeight, width: screenSize.width, height: self.collectionViewHeight)
        }, completion: nil)
        
        
        
    }
    
    @objc func onClickTransperentView () {
        
        let screenSize = UIScreen.main.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0, options: .curveEaseInOut,
                       animations: {
                        self.transparentView.alpha = 0
                        self.verseCollectionView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.collectionViewHeight)
        }, completion: nil)
        
        
    }
    
    func getChapters() {
        
        [DBT .getLibraryChapter(withDamId: self.damId, bookId: self.bookId, success: {(chapterList) in
            
            self.chapterList = chapterList as! [DBTChapter]
            
            self.collectionView.reloadData()
            
            
        }, failure: {(error) in
            print(error!)
            
        })]
    }
    
    func getVerseText( damId: String, bookId: String, _ chapterId: NSNumber, completion: @escaping ([DBTVerse]) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            DBT.getTextVerse(withDamId: damId, book: bookId, chapter: chapterId, verseStart: NSNumber(value: 1), verseEnd: NSNumber(value: 50), success: { (list) in
                DispatchQueue.main.async {
                    completion(list as! [DBTVerse])
                }
            } , failure: { (err: Any) in
                print(err as Any)
            })
        }
        
    }
    
    
}
