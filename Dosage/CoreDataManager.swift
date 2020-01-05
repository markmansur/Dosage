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
        let container = NSPersistentContainer(name: "DosageModels")
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
    
    func deleteAllMedications() {
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        let context = persistentContainer.viewContext
        
        do {
            try context.execute(deleteRequest)
        } catch let delErr {
            fatalError("Error deleting medications: \(delErr)")
        }
    }
    
    func addMedication(name: String, shape: Shape, startDate: Date, endDate: Date, dosageDays: [DayOfWeek], dosageTimes: [Time]) -> Medication {
        let context = persistentContainer.viewContext
        
        let medication = Medication(context: context)
        medication.name = name
        medication.shape = shape.rawValue
        medication.startDate = startDate
        medication.endDate = endDate
        
        dosageDays.forEach { (dayOfWeek) in
            let dosageDay = DosageDay(context: context)
            dosageDay.dayOfWeek = dayOfWeek.rawValue
            medication.addToDosageDays(dosageDay)
        }
        
        dosageTimes.forEach { (time) in
            let calendar = Calendar.current
            
            var components = DateComponents()
            components.calendar = calendar
            components.hour = time.isPM ? time.hour + 12 :  time.hour
            components.minute = time.min
            
            let date = calendar.date(from: components)
            
            let dosageTime = DosageTime(context: context)
            dosageTime.time = date
            
            medication.addToDosageTimes(dosageTime)
        }
        
        do {
            try context.save()
            return medication
        } catch let saveErr {
            fatalError("Error saving medication: \(saveErr)")
        }
    }
}
