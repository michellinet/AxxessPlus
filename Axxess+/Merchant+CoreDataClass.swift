//
//  Merchant+CoreDataClass.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/20/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import CoreData


public class Merchant: NSManagedObject {
    class func findOrCreateMerchant(matching merchantInfo: AxxessMerchant, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<Merchant> = Merchant.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", merchantInfo.id)

        let matches = try? context.fetch(request)
        if let matches = matches, matches.count > 0 { return }

        let merchant = Merchant(context: context)
        merchant.name = merchantInfo.name
        merchant.address = merchantInfo.address
        merchant.oneTimeDeals = NSSet(array: merchantInfo.oneTimeDeals)
        merchant.continualDeal = merchantInfo.continualDeal
        merchant.id = merchantInfo.id

        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

