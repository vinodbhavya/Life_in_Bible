//
//  BooksTableViewController.swift
//  Life_in_Bible
//
//  Created by bhavya on 14/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk
class BooksTableViewController: UITableViewController {
    
    var books = [DBTBook]()
    var damId: String?
    var selectedBook: DBTBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            cellIdentifier, for: indexPath) as? BookTableViewCell else {
                fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        
        
        let book = books[indexPath.row]
        cell.nameLabel.text = book.bookName
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedBook = books[indexPath.row]
        print("assignBook")
        //print(selectedBook)
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let chapterCV = mainStoryBoard.instantiateViewController(withIdentifier: "ChaptersCollectionViewController") as? ChaptersCollectionViewController else {
        return
        }

        

        if let chapterViewController = chapterCV as? ChaptersCollectionViewController {
            chapterViewController.damId = selectedBook!.damId
            chapterViewController.bookId = selectedBook!.bookId
        }
        print("beforePresent")
        print(chapterCV.bookId as Any)
        print(chapterCV.damId as Any)
        
        navigationController?.pushViewController(chapterCV, animated: true)
        //present(chapterCV, animated: true, completion: nil)
    }
    
    func getBooks()  {
        [DBT .getLibraryBook(withDamId: damId, success: {(bookList) in
            
            self.books = bookList as! [DBTBook]
            self.tableView.reloadData()
            
            
        }, failure: {(error) in
            print(error!)
        })]
    }
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if let assignBook = selectedBook as? DBTBook {
            print("assignBook")
            print(assignBook)
        }
       // print(selectedBook)
        if let chapterViewController = segue.destination as? ChaptersCollectionViewController {
            chapterViewController.damId = selectedBook?.damId
            chapterViewController.bookId = selectedBook?.bookId
            
        }
    }*/
}

