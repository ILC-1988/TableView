//
//  UserDefaults.swift
//  les_24_Table_View
//
//  Created by Илья Черницкий on 19.05.23.
//

import UIKit

extension UIViewController {
    
    func saveInUserDefaults(to array: [DataStr]) {
        let sortedArray = array.sorted(by: { $0.name < $1.name })
        let userDefaults = UserDefaults.init(suiteName: "user1")!
        let persons = PersonsData(data: sortedArray)
        let personData = try? JSONEncoder().encode(persons)
        userDefaults.set(personData, forKey: "persons")
    }
    
    func loadFromUserDefaults() -> [DataStr] {
        let userDefaults = UserDefaults.init(suiteName: "user1")!
        if let personsData = userDefaults.value(forKey: "persons") as? Data {
            let persons = try? JSONDecoder().decode(PersonsData.self, from: personsData)
            return persons?.data ?? []
        }
        else {
            return []
        }
        
    }
    
    struct PersonsData: Codable {
        let data: [DataStr]
    }
    
}
