//
//  Media+CoreDataProperties.swift
//  
//
//  Created by Adauto Pinheiro on 17/09/19.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var drawing: Data?
    @NSManaged public var note: String?
    @NSManaged public var photosPath: String?
    @NSManaged public var videosPath: String?
    @NSManaged public var voiceRecordsPath: String?
    @NSManaged public var day: Day?

}
