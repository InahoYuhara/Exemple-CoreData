//
//  TeamMembersViewController.swift
//  TestCoreData
//
//  Created by Antoine Hébert on 2017-02-23.
//  Copyright © 2017 Antoine Hébert. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TeamMembersViewController: UITableViewController {
    var team: Team!
    
    private var fetchedResultsController: NSFetchedResultsController<Member>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = team.name
        
        do{
            let context = CoreDataStack.instance.persistentContainer.viewContext
            let request = NSFetchRequest<Member>(entityName: Member.ENTITY_NAME)
            request.sortDescriptors = [NSSortDescriptor(key: "name",ascending: true)]
            request.predicate = NSPredicate(format: "team.name == %@", team.name)
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResultsController.performFetch()
            
        
    } catch {}
    }
        override func numberOfSections(in tabkeView: UITableView) -> Int{
            return fetchedResultsController.sections?.count ?? 1
        }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let sections = fetchedResultsController.sections{
                return sections[section].numberOfObjects
            }else {
                return fetchedResultsController.fetchedObjects!.count
            }
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "member_cell", for: indexPath)
        
        let member: Member = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = "\(member.name): \(member.team.name)"
        return cell
    }
    

}
