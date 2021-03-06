//
//  GroupListTableViewController.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import UIKit

class GroupListTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    
    // MARK: - LyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - IBActions
    @IBAction func addGroupButtontapped(_ sender: Any) {
        GroupController.sharedInstance.createGroup()
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupController.sharedInstance.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        
        // Configure the cell...
        let group = GroupController.sharedInstance.groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = String(group.people.count)
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let group = GroupController.sharedInstance.groups[indexPath.row]
            GroupController.sharedInstance.deleteGroup(group: group)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPeopleController" {
            if let index = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? PersonListTableViewController {
                    let group = GroupController.sharedInstance.groups[index.row]
                    destination.group = group
                }
            }
        }
    }

