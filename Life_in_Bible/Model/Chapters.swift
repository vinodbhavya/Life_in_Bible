//
//  Chapters.swift
//  Life_in_Bible
//
//  Created by bhavya on 14/11/19.
//  Copyright © 2019 Mohammad Saiful Kabir. All rights reserved.
//

import Foundation
import UIKit
class Chapter {
    
    var bookid: String
    var chaptername: String
    var chapterid: Int
   
    
    init(bookid: String, chaptername: String, chapterid: Int) {
        self.bookid = bookid
        self.chaptername = chaptername
        self.chapterid = chapterid
        
    }
}
