//
//  Company+CoreDataProperties.swift
//  MAP
//
//  Created by Dmitry Kulakoff on 15.10.15.
//  Copyright © 2015 Dmitriy Kulakov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Company {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?

}
