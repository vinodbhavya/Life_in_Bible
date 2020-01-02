//
//  BooksTableViewController.swift
//  Life_in_Bible
//
//  Created by bhavya on 14/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import UIKit
import dbt_sdk
class BooksTableViewController: UITableViewController, UISearchBarDelegate {
    
    var books: [DBTBook] = []
    var damId: String?
    var selectedBook: DBTBook?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
        tableView.dataSource = self
        searchBar.delegate = self
        
        
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
        
        
        cell.nameLabel?.text = books[indexPath.row].bookName
        
        return cell
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        books = searchText.isEmpty ? books : books.filter({(book: DBTBook) -> Bool in
            return  book.bookName.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedBook = books[indexPath.row]
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let chapterCV = mainStoryBoard.instantiateViewController(withIdentifier: "ChaptersCollectionViewController") as? ChaptersCollectionViewController else {
            return
        }
        
        
        if let chapterViewController = chapterCV as? ChaptersCollectionViewController {
            chapterViewController.damId = selectedBook!.damId
            chapterViewController.bookId = selectedBook!.bookId
        }
        
        
        navigationController?.pushViewController(chapterCV, animated: true)
        
    }
    
    func getBooks()  {
       DBT.getLibraryBook(withDamId: damId, success: {(bookList) in
            
            self.books = bookList as! [DBTBook]
            self.tableView.reloadData()
            
            
        }, failure: {(error) in
            print(error!)
        })
    }
    
}

