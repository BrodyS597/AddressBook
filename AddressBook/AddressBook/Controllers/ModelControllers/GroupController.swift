//
//  GroupController.swift
//  AddressBook
//
//  Created by Brody Sears on 1/24/22.
//

import Foundation

class GroupController {
    
    // MARK: - Properties
    static var sharedInstance = GroupController()
    var groups: [Group] = []
    
    // MARK: - Initializers
    init() {
        loadContactsFromDisk()
    }
    
    // MARK: - CRUD FUNCS
    
    func createGroup(name: String = "Untitled Group", people:[Person] = []) {
        let group = Group(name: name, people: people)
        groups.append(group)
        saveContactsToDisk()
    }
    
    func updateGroup(group: Group, name: String, people: [Person]) {
        group.name = name
        group.people = people
        saveContactsToDisk()
    }
    
    func deleteGroup(group: Group) {
        guard let index = groups.firstIndex(of: group) else { return }
        groups.remove(at: index)
        saveContactsToDisk()
    }
    
    func saveContactsToDisk() {
        //Get address to save to
        guard let url = fileURL else { return }
        do {
        //Convert/Encode
            let data = try JSONEncoder().encode(groups)
        //Save the data to the address
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadContactsFromDisk() {
        //Get the address your data is saved at
        guard let url = fileURL else { return }
        do {
        //Load the data from the address
        let data = try Data(contentsOf: url)
        //decode that data into our swift model object
            let groups = try JSONDecoder().decode([Group].self, from: data)
            self.groups = groups
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - Computed Property
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("addressbook.json")
        return url
    }
    
} //End of class






