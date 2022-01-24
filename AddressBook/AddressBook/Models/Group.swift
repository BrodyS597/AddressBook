//
//  Group.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import Foundation

class Group {
    let id: UUID
    var name: String
    var people: [Person]
    
    init(id: UUID = UUID(), name: String, people: [Person] = [] ) {
        self.id = id
        self.name = name
        self.people = people
    }
}// end of class

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.people == rhs.people
    }
}
