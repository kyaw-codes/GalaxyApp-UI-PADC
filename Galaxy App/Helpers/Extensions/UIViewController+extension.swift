//
//  UIViewController+extension.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 27/07/2021.
//

import UIKit

extension UIViewController {
    
    func setter<Object: AnyObject, Value>(
        for object: Object,
        keyPath: ReferenceWritableKeyPath<Object, Value>
    ) -> (Value) -> Void {
        return { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
