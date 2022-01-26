//
//  PersonTableViewCell.swift
//  AddressBook
//
//  Created by Brody Sears on 1/25/22.
//

import UIKit

protocol PersonTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonWasTapped(for cell: PersonTableViewCell)
}

class PersonTableViewCell: UITableViewCell {
    
    // MARK: -IBOutlets
    @IBOutlet weak var personLabeltext: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: PersonTableViewCellDelegate?
    
    // MARK: - Properties
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func toggleFavoriteButtonTapped(_ sender: UIButton) {
        delegate?.toggleFavoriteButtonWasTapped(for: self)
    }
    
    // MARK: - Helper Function
    func updateViews() {
        guard let unwrappedPerson = person else { return }
        personLabeltext.text = unwrappedPerson.name
        let favoriteImageName = unwrappedPerson.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = unwrappedPerson.isFavorite ? .systemBlue : .systemYellow
        PersonController.toggleIsFavorite(person: unwrappedPerson)
    
    }
    
    
}// END of class
