//
//  PersonListTableViewController.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    var group: Group?

    // MARK: - Computed Property
    private var filteredPeople: [Person] {
        if favoriteSwitch.isOn {
            return group?.people.filter { $0.isFavorite } ?? []
        } else {
            return group?.people ?? []
        }
    }
    
    // MARK: -IBOutlets
    @IBOutlet weak var groupnameTextFIeld: UITextField!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        groupnameTextFIeld.text = group?.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let group = group,
              let newName = groupnameTextFIeld.text else { return }
        GroupController.sharedInstance.updateGroup(group: group, name: newName)
    }
    
    // MARK: -IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let group = group else { return }
        PersonController.createPerson(group: group)
        tableView.reloadData()
        
    }
    
    @IBAction func favoriteSwitchToggled(_ sender: Any) {
        tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return filteredPeople.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell()}
        
        // Configure the cell...
        //You need to get the person from the array inorder to identify and display the (name) value
        //assigning the value of the specific person from a group of people that matches the index path.row of the current cell its about to display
        
        // setting the cell to the "textLabel"'s text value to the value of the (optional) person's name
        let person = filteredPeople[indexPath.row]
        cell.person = person
        cell.delegate = self
        
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let group = group else { return }
            let person = group.people[indexPath.row]
            PersonController.deletePerson(person: person, group: group)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
           
            //Destination; verifying if the segues destination leads to the viewController we want (PersonDetailViewController) and allows access to its properties on that viewController
           let destination = segue.destination as? PersonDetailViewController,
           
            // Identifies the cell that was "selected"
           let indexPath = tableView.indexPathForSelectedRow {
            
            //Object to send; using the index we discovered to retreive the PERSON we want to pass along, that matches the one in our array of people
            let person = group?.people[indexPath.row]
            
            //Object to receive; sets the value of the PERSON on the destination to the person we just received.
            destination.person = person
        }
        
    }
} // End of class

extension PersonListTableViewController: PersonTableViewCellDelegate {
    func toggleFavoriteButtonWasTapped(for cell: PersonTableViewCell) {
        guard let person = cell.person else { return }
        PersonController.toggleIsFavorite(person: person)
        tableView.reloadData()
        
    }
    
    
}
