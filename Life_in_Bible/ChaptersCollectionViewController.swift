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
    var versesList: [DBTVerse] = []
    var bookId: String?
    var damId: String?
    var transparentView = UIView()
    var verseCollectionViewDataSource: VerseCollectionViewDataSource?
    
    
    
    
    private let reuseIdentifier = "ChapterCell"
    private let semaphore = DispatchSemaphore(value: 0)
    private let queue = DispatchQueue.global()
    
    var collectionViewHeight: CGFloat = 7 * 85
    
    
    
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
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        titleLabel.textAlignment = .center
        titleLabel.text = chapterList[indexPath.row].chapterId
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name:"chalkboard SE", size: 19)
        cell.chapterButton.addSubview(titleLabel)
        
        return cell
        
    }
    
    
    @objc func buttonTapped(_ sender: CustomButton)
    {
        
        let selectedChapter = chapterList[sender.tag]
        
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        transparentView.alpha = 0
        window?.addSubview(transparentView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransperentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        
        
        
        getVerseText(damId: selectedChapter.damId, bookId: selectedChapter.bookId, NumberFormatter().number(from: selectedChapter.chapterId)!, completion: { [weak self] (list) in
            
            self?.verseCollectionViewDataSource = VerseCollectionViewDataSource(list)
            self?.verseCollectionViewDataSource?.verseDelegate = self
            self?.verseCollectionView.delegate = self?.verseCollectionViewDataSource
            self?.verseCollectionView.dataSource = self?.verseCollectionViewDataSource
            self?.collectionViewHeight = CGFloat((list.count))/5 * 85
            self?.verseCollectionView.reloadData()
            
            let screenSize = UIScreen.main.bounds.size
            self!.verseCollectionView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self!.collectionViewHeight)
            window?.addSubview(self!.verseCollectionView)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 1.0, options: .curveEaseInOut,
                           animations: {
                            self!.transparentView.alpha = 0.5
                            self!.verseCollectionView.frame = CGRect(x: 0, y: screenSize.height - self!.collectionViewHeight, width: screenSize.width, height: self!.collectionViewHeight)
            }, completion: nil)
            
        })
        
        
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
                    self.versesList = list as! [DBTVerse]
                    completion(list as! [DBTVerse])
                }
            } , failure: { (err: Any) in
                print(err as Any)
            })
        }
        
    }
    
    
}

extension ChaptersCollectionViewController: VerseCollectionViewDelegate {
    func userDidTap(into selectedVerse: DBTVerse) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let verseCV = mainStoryBoard.instantiateViewController(identifier: "VerseTableViewController") as? VerseTableViewController else {
            return
        }
        
        if let verseViewController = verseCV as? VerseTableViewController {
            verseViewController.selectedVerse = selectedVerse
        }
        
        present(verseCV, animated: true, completion: nil)
        
    }
    
    
}
