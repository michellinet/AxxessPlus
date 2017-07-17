//
//  Merchant+CoreDataProperties.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/16/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import CoreData


extension Merchant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Merchant> {
        return NSFetchRequest<Merchant>(entityName: "Merchant")
    }

    @NSManaged public var address: String?
    @NSManaged public var continualDeal: String?
    @NSManaged public var hasUsedOneTimeDeal: Bool
    @NSManaged public var name: String?
    @NSManaged public var oneTimeDeal: String?
    @NSManaged public var id: String?

}
