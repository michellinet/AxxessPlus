//
//  OneTimeDeal+CoreDataProperties.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/20/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import CoreData


extension OneTimeDeal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OneTimeDeal> {
        return NSFetchRequest<OneTimeDeal>(entityName: "OneTimeDeal")
    }

    @NSManaged public var id: String?
    @NSManaged public var oneTimeDealDescription: String?
    @NSManaged public var used: Bool
    @NSManaged public var merchant: Merchant?

}
