//
//  Person.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import Foundation

class Person {
    let id:UUID
    var name: String
    var address: String
    
    // MARK: - Initializer
    init(id: UUID = UUID(), name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}//End of class


extension Person: Equatable {
static func == (lhs: Person, rhs: Person) -> Bool {
    lhs.id == rhs.id &&
    lhs.name == rhs.name &&
    lhs.address == rhs.address
    }
}

