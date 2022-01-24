//
//  PersonController.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import Foundation

class PersonController {
    
    // MARK: - CRUD FUNCS
    
    static func createPerson(name: String = "New Contact", address: String = "", group: Group) {
        let person = Person(name: name, address: address)
        group.people.append(person)
    }
    
    static func deletePerson(person: Person, group: Group) {
        guard let index = group.people.firstIndex(of: person) else { return }
        group.people.remove(at: index)
    }
    
    static func updatePerson(person: Person, name: String, address: String) {
        person.address = address
        person.name = name
    }
    
}
