//
//  CoreDataManager.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 03.03.2023.
//


//import Foundation
//import CoreData
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//
//    private init() {}
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "moviesAppUiKitAervea")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    lazy var managedObjectContext: NSManagedObjectContext = {
//        return self.persistentContainer.viewContext
//    }()
//
//    // MARK: - CRUD
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//    func save<T: NSManagedObject>(_ object: T, uniqueIdentifierKey: String) {
//        let entityName = String(describing: T.self)
//
//        let request = NSFetchRequest<T>(entityName: entityName)
//        request.predicate = NSPredicate(format: "%K == %@", uniqueIdentifierKey, object.value(forKey: uniqueIdentifierKey) as! CVarArg)
//
//        do {
//            let result = try managedObjectContext.fetch(request)
//            if let existingObject = result.first{
//                // An object with the same unique identifier already exists in the context, so update its properties instead of adding a new object.
//                existingObject.setValuesForKeys(object.dictionaryWithValues(forKeys: object.entity.attributesByName.keys.map({ $0 })))
//            } else {
//                // No object with the same unique identifier exists, so add the new object to the context.
//                managedObjectContext.insert(object)
//            }
//
//            try managedObjectContext.save()
//        } catch {
//            print("Error saving object: \(error.localizedDescription)")
//        }
//    }
//
//    func delete<T: NSManagedObject>(_ object: T) {
//        managedObjectContext.delete(object)
//        saveContext()
//    }
//
//    // MARK: - Data Fetching
//
//    func fetchData<T: NSManagedObject>(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
//        let request = NSFetchRequest<T>(entityName: entityName)
//        request.predicate = predicate
//        request.sortDescriptors = sortDescriptors
//
//        do {
//            let result = try managedObjectContext.fetch(request)
//            return result
//        } catch {
//            print("Error fetching data: \(error.localizedDescription)")
//            return []
//        }
//    }
//}


//extension Movie {
//    static func generateUniqueIdentifier() -> String {
//        return UUID().uuidString
//    }
//}

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "moviesAppUiKitAervea")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    // MARK: - CRUD
    func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }

    func save<T: NSManagedObject>(_ object: T) {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving object: \(error.localizedDescription)")
        }
    }

    func delete<T: NSManagedObject>(_ object: T) {
        managedObjectContext.delete(object)
        save(object)
    }
//    func save<T: NSManagedObject>(_ object: T) {
//        guard !managedObjectContext.registeredObjects.contains(where: { $0 == object }) else {
//            // The object already exists in the context, so there is no need to save it again.
//            return
//        }
//
//        do {
//            try managedObjectContext.save()
//        } catch {
//            print("Error saving object: \(error.localizedDescription)")
//        }
//    }

//    func save<T: NSManagedObject>(_ object: T) {
//        let entityName = String(describing: T.self)
//        let uniqueIdentifierKey = "id" // Replace this with the name of the attribute that represents the unique identifier for your entity
//
//        let request = NSFetchRequest<T>(entityName: entityName)
//        request.predicate = NSPredicate(format: "%K == %@", uniqueIdentifierKey, object.value(forKey: uniqueIdentifierKey) as! CVarArg)
//
//        do {
//            let result = try managedObjectContext.fetch(request)
//            if let existingObject = result.first{
//                // An object with the same unique identifier already exists in the context, so update its properties instead of adding a new object.
//                existingObject.setValuesForKeys(object.dictionaryWithValues(forKeys: object.entity.attributesByName.keys.map({ $0 })))
//
//
//            } else {
//                // No object with the same unique identifier exists, so add the new object to the context.
//                managedObjectContext.insert(object)
//            }
//
//            try managedObjectContext.save()
//        } catch {
//            print("Error saving object: \(error.localizedDescription)")
//        }
//    }
    // MARK: - Data Fetching

    func fetchData<T: NSManagedObject>(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors

        do {
            let result = try managedObjectContext.fetch(request)
            return result
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }
}


