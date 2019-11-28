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
    var dam_id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBooks()
        print(dam_id)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "BookTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            cellIdentifier, for: indexPath) as? BookTableViewCell else {
                fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        
        let book = books[indexPath.row]
        cell.nameLabel.text = book.bookName
        
        return cell
        
    }
    
    func getBooks()  {
        [DBT .getLibraryBook(withDamId: dam_id, success: {(bookList) in
            
            for book in (bookList)! {
                print((book as! DBTBook).bookName!)
            }
            
            self.books = bookList as! [DBTBook]
           
            //  print(bookList)
            self.tableView.reloadData()
            
            
        }, failure: {(error) in
            print(error!)
        })]
    }
    
    
    //  [DBT .getLibraryBook(withDamId: dam_id, success:createBookList, failure:handleError)]
    /*  func createBookList(_ bookList:[Any]?) {
     }
     func handleError(_ error:Error?) {
     }*/
    
    

    
    
    
    /* let cell = UITableViewCell()
     cell.textLabel?.text = books[indexPath.row] as? String
     // Configure the cell...
     
     return cell*/
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
