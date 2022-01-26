//
//  PersonDetailViewController.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    // MARK: -Properties
    var person: Person?
    
    // MARK: -IBOutlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    func updateViews() {
        guard let person = person else { return }
        nameTextField.text = person.name
        addressTextField.text = person.address
    }
    // MARK: -IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
              let address = addressTextField.text else { return }
        if let person = person {
            PersonController.updatePerson(person: person, name: name, address: address)
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
