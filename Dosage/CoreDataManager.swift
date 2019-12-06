//
//  CoreDataManager.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Models")
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Failed to load persistent stores: \(err)")
            }
        }
        return container
    }()
    
    func getAllMedications() -> [Medication] {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
        let context = persistentContainer.viewContext
        
        do {
            let medications = try context.fetch(fetchRequest)
            return medications
        } catch let fetchErr {
            fatalError("Error fetching medications: \(fetchErr)")
        }
    }
    
    func addMedication(name: String) -> Medication {
        let context = persistentContainer.viewContext
        
        let medication = Medication(context: context)
        medication.name = name
        
        do {
            try context.save()
            return medication
        } catch let saveErr {
            fatalError("Error saving medication: \(saveErr)")
        }
    }
}
