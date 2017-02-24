//
//  Member.swift
//  TestCoreData
//
//  Created by Antoine Hébert on 2017-02-16.
//  Copyright © 2017 Antoine Hébert. All rights reserved.
//

import Foundation
import CoreData

class Member: NSManagedObject {
    static let ENTITY_NAME: String = "Member"
    
    @NSManaged var name: String
    @NSManaged var team: Team
    
    
}
