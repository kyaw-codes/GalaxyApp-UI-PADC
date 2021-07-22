//
//  MovieTypeVM.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 22/07/2021.
//

import Foundation

class MovieTypeVM {
    
    var title: String = ""
    var isSelected = false
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
