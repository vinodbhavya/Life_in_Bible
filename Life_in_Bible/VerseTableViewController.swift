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
import AVFoundation


class VerseTableViewController: UITableViewController {
    
    var verseList: [DBTVerse] = []
    var damId: String?
    var selectedVerse: DBTVerse?
    var player: AVAudioPlayer?
    var audio: [DBTAudioPath]?
    
    private let reuseIdentifier = "VerseCell"
    
    override func viewDidLoad() {
        getVerses()
        super.viewDidLoad()
        
        let audioDamId = damId != AppConstants.otTextDamId ? AppConstants.ntAudioDamId : AppConstants.otAudioDamId
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        let slider = UISlider()
        slider.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        slider.center = .zero
        slider.minimumTrackTintColor = .lightGray
        slider.maximumTrackTintColor = .lightGray
        slider.thumbTintColor = .gray
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.setValue(0.5, animated: true)
        slider.addTarget(self, action: #selector(changeVolume(_:)), for: .valueChanged)
        
        
        let btnVol = UIButton(type: .custom)
        btnVol.setImage(#imageLiteral(resourceName: "Bible"), for: .normal)
        btnVol.setTitle("", for: .normal)
        btnVol.setTitleColor(btnVol.tintColor, for: .normal)
        
        
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(play))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(customView: btnVol)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        
        items.append(
            UIBarButtonItem(customView: slider)
        )
        
        self.toolbarItems = items
        self.navigationController?.isToolbarHidden = true
    }
    
    @objc func changeVolume(_ sender: UISlider){
        let selectedValue = Float((sender).value)
        self.player?.volume = selectedValue
    }
    
    @objc func play() {
        
        let audioDamId = damId != AppConstants.otTextDamId ? AppConstants.ntAudioDamId : AppConstants.otAudioDamId
        getAudioPath(damId: audioDamId, bookId: selectedVerse!.bookId, selectedVerse!.chapterId)
        
    }
    
    @objc func addTapped() {
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
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
        let text = self.verseList[indexPath.row].verseId!
        cell.btn.frame = CGRect(x: 10, y: 15, width: 65, height: 65)
        cell.btn.setTitleColor(.black, for: .normal)
        cell.btn.layer.masksToBounds = true
        cell.btn.layer.cornerRadius = 33.0
        cell.btn.setTitle((text as! String), for: .normal)
        cell.btn.backgroundColor = .gray
        
        return cell
        
    }
    
    
    @IBAction func volumeSlider(_ sender: UISlider) {
    }
    
    
    
    func getVerses() {
        
        DBT .getTextVerse(withDamId: damId, book: selectedVerse?.bookId, chapter: selectedVerse?.chapterId, verseStart: 1 as NSNumber, verseEnd: 200 as NSNumber, success: {(verseList) in
            
            self.verseList = verseList as! [DBTVerse]
            self.tableView.reloadData()
        }, failure: {(error) in
            print(error!)
            
        })
        
    }
    
    private func getAudioPath( damId: String, bookId: String, _ chapterId: NSNumber) {
        DBT.getAudioPath(withDamId: damId, book: bookId, chapter: chapterId, success: {
            (list) in
            self.audio = list as? [DBTAudioPath]
            let url = AppConstants.audioPath.appending(self.audio![0].path)
            print(url)
            self.playAudio(location: url)
            
        }) { (err) in
            print(err as Any)
        }
    }
    
    private func playAudio(location: String){
        
        guard let url = URL(string: location) else { return }
        
        do {
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            self.player = try AVAudioPlayer(data: soundData)
            self.player?.prepareToPlay()
            self.player?.volume = 0.5
            self.player?.play()
            
            
        } catch {
            print(error)
        }
        
    }
    
    
    
}
