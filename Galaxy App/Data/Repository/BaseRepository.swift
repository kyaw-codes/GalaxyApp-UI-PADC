//
//  BaseRepo.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import CoreData

class BaseRepository: NSObject {
    
    let coreData : CoreDataStack = CoreDataStack.shared
    let context : NSManagedObjectContext = CoreDataStack.shared.context
}
