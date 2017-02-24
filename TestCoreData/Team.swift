//
//  Team.swift
//  TestCoreData
//
//  Created by Antoine Hébert on 2017-02-16.
//  Copyright © 2017 Antoine Hébert. All rights reserved.
//

import Foundation
import CoreData

class Team: NSManagedObject{
    @NSManaged var name: String
    @NSManaged var members: Set<Member>
    
    static let ENTITY_NAME: String = "Team"
    
    var membersCount: Int{
        return members.count
    }
    
}
