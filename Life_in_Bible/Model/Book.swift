//
//  Books.swift
//  Life_in_Bible
//
//  Created by bhavya on 14/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import Foundation
import UIKit
import dbt_sdk
class Book {
    
    var bookname: String 
    var bookid: String
    var chapterList: Int
    
init(bookname: String, bookid: String, chapterList: Int){
    self.bookname = bookname
    self.bookid = bookid
    self.chapterList = chapterList
    
    
}
}





