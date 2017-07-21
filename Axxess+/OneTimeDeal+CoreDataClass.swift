//
//  OneTimeDeal+CoreDataClass.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/20/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import CoreData


public class OneTimeDeal: NSManagedObject {
    class func findOrCreateOneTimeDeal(matching oneTimeDealInfo: AxxessOneTimeDeal, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<OneTimeDeal> = OneTimeDeal.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", oneTimeDealInfo.id)

        let matches = try? context.fetch(request)
        if let matches = matches, matches.count > 0 { return }

        let oneTimeDeal = OneTimeDeal(context: context)
        oneTimeDeal.oneTimeDealDescription = oneTimeDealInfo.oneTimeDealDescription
        oneTimeDeal.id = oneTimeDealInfo.id

        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
