//
//  ViewController.swift
//  TestCoreData
//
//  Created by Antoine Hébert on 2017-02-16.
//  Copyright © 2017 Antoine Hébert. All rights reserved.
//

import UIKit
import CoreData

class TeamsTableViewController: UITableViewController {

    private var fetchedResultsController: NSFetchedResultsController<Team>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let context = CoreDataStack.instance.persistentContainer.viewContext
        let request = NSFetchRequest<Team>(entityName: Team.ENTITY_NAME)
        
        do{
            let results = try context.fetch(request)
            
            if(results.count == 0){
                
                for i in 1...3{
                
                    let teamEntity = NSEntityDescription.insertNewObject(forEntityName: Team.ENTITY_NAME, into: context) as! Team
                    teamEntity.name = "Dummy Data \(i)"
                
                    for j in 0...i{
                        let memberEntity = NSEntityDescription.insertNewObject(forEntityName: Member.ENTITY_NAME, into: context) as! Member
                        
                        memberEntity.name = "Member "
                        memberEntity.team = teamEntity
                    }
                }
                
                CoreDataStack.instance.saveContext()
            }
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil, cacheName: nil)
            try fetchedResultsController.performFetch()
            
        }catch{
            print("Fetch error")
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "team_cell", for: indexPath)
        let team = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = "Members: \(team.membersCount)"
        
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "team_members_segue"){
            if let dest = segue.destination as? TeamMembersViewController,
                let cell = sender as? UITableViewCell,
                let IndexPath = tableView.indexPath(for: cell){
                let team = fetchedResultsController.object(at: IndexPath)
                dest.team = team
            }
        }
    }
    
}

