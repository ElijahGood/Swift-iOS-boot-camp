//
//  ArticleManager.swift
//  inazarin2019
//
//  Created by Illia NAZARINA on 4/12/19.
//

import UIKit
import CoreData

public class ArticleManager: NSObject {
    
    var managedObjectContext: NSManagedObjectContext
    let articleFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
    
    //custom init from apple documentation
    public override init() {
        let tempBundle = Bundle(identifier: "org.cocoapods.inazarin2019")
        guard let modelURL = tempBundle?.url(forResource: "article", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("inazarin2019.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
    }
    
    public func getAllArticles() -> [Article] {
        print("getAllArticles")
        articleFetch.predicate = NSPredicate(value: true)
        do {
            let res = try managedObjectContext.fetch(articleFetch) as! [Article]
            return res
        } catch {
            return []
        }
    }
    
    public func getArticles(withLang lang: String) -> [Article] {
        print("getArticles(withLang lang: String)")
        articleFetch.predicate = NSPredicate(format: "language == %@", lang)
        do {
            let res = try managedObjectContext.fetch(articleFetch) as! [Article]
            return res
        } catch {
            return []
        }
    }
    
    public func getArticles(containString str: String) -> [Article] {
        print("getArticles(containString str: String)")
        articleFetch.predicate = NSPredicate(format: "title CONTAINS %@ || content CONTAINS %@", str, str)
        do {
            let res = try managedObjectContext.fetch(articleFetch) as! [Article]
            return res
        } catch {
            return []
        }

    }
    
    public func removeArticle(article : Article) {
        print("removeArticle(article : Article)")
        managedObjectContext.delete(article)
    }
    
    public func save() {
        print("SAVE")
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
}
