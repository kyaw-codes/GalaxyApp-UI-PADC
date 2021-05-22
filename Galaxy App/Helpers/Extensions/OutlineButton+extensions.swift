//
//  OutlineButton+extensions.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 21/05/2021.
//

import UIKit

extension OutlineButton {
    
    convenience init(title: String, _ completion: (OutlineButton) -> Void) {
        self.init(title: title)
        
        completion(self)
    }
}
