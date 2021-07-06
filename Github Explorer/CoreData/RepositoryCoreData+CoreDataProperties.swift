//
//  RepositoryCoreData+CoreDataProperties.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//
//

import Foundation
import CoreData


extension RepositoryCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepositoryCoreData> {
        return NSFetchRequest<RepositoryCoreData>(entityName: "RepositoryCoreData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var ownerName: String?
    @NSManaged public var ownerAvatarUrl: String?
    @NSManaged public var ownerId: Int64

}

extension RepositoryCoreData : Identifiable {

}
