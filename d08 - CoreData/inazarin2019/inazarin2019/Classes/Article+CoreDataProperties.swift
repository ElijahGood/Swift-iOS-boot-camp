//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Illia NAZARINA on 4/12/19.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var language: String?
    @NSManaged public var modification_date: NSDate?
    @NSManaged public var title: String?

    override public var description: String {
        return "\(title!)\(content!)\(language!)\(creation_date!)\(modification_date!)"
    }
    
    public func sayHi(){
        print("Hello World")
    }
}
