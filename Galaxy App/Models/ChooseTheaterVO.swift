//
//  ChooseTheaterVO.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/06/2021.
//

import Foundation

public class ChooseTheaterVO {
    
    var title: String
    var items: [Item]
    
    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
    
    class Item {
        var title: String
        var isSelected: Bool
        
        init(title: String, isSelected: Bool = false) {
            self.title = title
            self.isSelected = isSelected
        }
    }
}
