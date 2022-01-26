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
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    func updateViews() {
        guard let person = person else { return }
        nameTextField.text = person.name
        addressTextField.text = person.address
        updatefavoriteButton()
    }
    
    func updatefavoriteButton() {
        guard let unwrappedPerson = person else { return }
        let favoriteImageName = unwrappedPerson.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = unwrappedPerson.isFavorite ? .systemBlue : .systemYellow
        PersonController.toggleIsFavorite(person: unwrappedPerson)
    }
    
    // MARK: -IBActions
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let person = person else { return }
        PersonController.toggleIsFavorite(person: person)
        updatefavoriteButton()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
              let person = person,
              let address = addressTextField.text else { return }
        
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

