//
//  AppDelegate.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAxxessMerchants()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyAxxess")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func setupAxxessMerchants() {
        let managedContext = persistentContainer.viewContext
        
        let merchantsForCurrentVersion = getMerchantsForCurrentVersion(context: managedContext)
        
        for merchant in merchantsForCurrentVersion {
            Merchant.findOrCreateMerchant(matching: merchant, in: managedContext)
        }
        
    }
    
    func getMerchantsForCurrentVersion(context: NSManagedObjectContext) -> [AxxessMerchant] {
        var merchants = [AxxessMerchant]()
       
        let merchant1 = AxxessMerchant(name: "Altamirano's Mexican Grill", address: "5838 Hollister Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value $10). Dine in only.", id: "23")], continualDeal: "Save 10% Thereafter.", id: "1")
        merchants.append(merchant1)
        
        let merchant2 = AxxessMerchant(name: "Boathouse", address: "2891 Cliff Dr, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Midweek Breakfast Special: Buy One Breakfast Entree, Get One Free. (Valid Mon-Thurs 7am-11am only. Excludes holidays.)", id: "180")], continualDeal: "Free Coffee, Tea or Juice with Breakfast Entree Purchase Thereafter. (Valid Mon-Thurs 7am-11am only. Excludes holidays.)", id: "2")
        merchants.append(merchant2)
        
        let merchant3 = AxxessMerchant(name: "Borrello's Pizza & Pastaria", address: "3807 Santa Claus Ln, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Save 50% on Your First Pizza.", id: "13")], continualDeal: "Save 10% Thereafter.", id: "3")
        merchants.append(merchant3)
        
        let merchant4 = AxxessMerchant(name: "Brasil Arts Cafe", address: "1230 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "109")], continualDeal: "Save 10% Thereafter.", id: "4")
        merchants.append(merchant4)
        
        let merchant5 = AxxessMerchant(name: "Ca' Dario Pizzeria", address: "29 E Victoria St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Pizza or Panini, Get One Free.", id: "303")], continualDeal: "Save 10% Thereafter. (Dine in only.)", id: "5")
        merchants.append(merchant5)
        
        let merchant6 = AxxessMerchant(name: "Ca' Dario Ristorante", address: "37 E Victoria St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Lunch Entree, Get One Free.", id: "293")], continualDeal: "Save 10% Thereafter. (Valid Mon-Thurs)", id: "6")
        merchants.append(merchant6)
        
        let merchant7 = AxxessMerchant(name: "Cafe 154", address: "4151 Foothill Rd, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Salad or Sandwich, Get One Free.", id: "161")], continualDeal: "Save 10% Thereafter.", id: "7")
        merchants.append(merchant7)
       
        //no continual
        let merchant8 = AxxessMerchant(name: "Cajun Kitchen", address: "1924 De La Vina St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Espresso Drink, Get One Free OR Free Espresso Drink with Purchase of Entree. (Max 2 cards per table.)", id: "174")], continualDeal: "No continual deals.", id: "8")
        merchants.append(merchant8)
        
        let merchant9 = AxxessMerchant(name: "California Pasta", address: "811 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free OR Buy One Entree & Fountain Soda, Get a Free Entree & Fountain Soda", id: "35")], continualDeal: "Save 10% Thereafter.", id: "9")
        merchants.append(merchant9)
        
        let merchant10 = AxxessMerchant(name: "CalTaco", address: "7320 Hollister Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy Any Burger or Breakfast Item, Get One Free.", id: "290")], continualDeal: "Save 10% Thereafter.", id: "10")
        merchants.append(merchant10)
        
        let merchant11 = AxxessMerchant(name: "Casa Blanca", address: "330 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Lunch or Sunday Brunch Entree, Get One 50% Off.", id: "68"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Dinner Entree, Get One 50% Off.", id: "203")], continualDeal: "Buy Two Entrees, Get an Appetizer or Dessert Free. Everytime!", id: "11")
        merchants.append(merchant11)
        
        let merchant12 = AxxessMerchant(name: "Cecco Ristorante", address: "475 1st St, Solvang, CA 93463", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "237")], continualDeal: "Save 10% Thereafter.", id: "12")
        merchants.append(merchant12)

        let merchant13 = AxxessMerchant(name: "Chase Restaurant Lounge", address: "1012 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "291")], continualDeal: "Save 10% on Lunch Entrees.", id: "13")
        merchants.append(merchant13)

        let merchant14 = AxxessMerchant(name: "China Bowl & State Street Cafe", address: "440 E Ortega St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy Two Entrees, Get the Third Free. (Not valid on delivery.)", id: "137")], continualDeal: "Save 15% Thereafter. (Not valid on delivery.)", id: "14")
        merchants.append(merchant14)

        let merchant15 = AxxessMerchant(name: "China Palace", address: "1070 Coast Village Rd, Santa Barbara, CA 93108", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (One Axxess Card per table.)", id: "17")], continualDeal: "Save 10% Thereafter.", id: "15")
        merchants.append(merchant15)

        let merchant16 = AxxessMerchant(name: "China Pavillion", address: "1202 Chapala St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max value $15. Valid for dine-in & take out orders. Limit 1 per table. Excludes Chinese New Year & all holidays.)", id: "44")], continualDeal: "Save 10% Thereafter. (Max value $15. Valid for dine-in & take out orders. Limit 1 per table. Excludes Chinese New Year & all holidays.)", id: "16")
        merchants.append(merchant16)

        let merchant17 = AxxessMerchant(name: "CHOMP", address: "1693 Mission Dr, Solvang, CA 93463", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "77")], continualDeal: "", id: "17")
        merchants.append(merchant17)

        let merchant18 = AxxessMerchant(name: "Chuck's Waterfront Grill", address: "113 Harbor Way, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Not valid with other offers, specials or promotions. 1 card per party/table.)", id: "173")], continualDeal: "Save $7 on the Purchase of Two Dinner Entrees. Everytime! (Not valid with other offers, specials or promotions. 1 card per party/table.)", id: "18")
        merchants.append(merchant18)

        let merchant19 = AxxessMerchant(name: "Cody's Cafe", address: "4898 Hollister Ave, Santa Barbara, CA 93111", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "74")], continualDeal: "", id: "19")
        merchants.append(merchant19)

        let merchant20 = AxxessMerchant(name: "Convino", address: "901 E Cabrillo Blvd, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Food Item, Get One Free. (Max Value $20. Dine-in only. Max 2 cards per table. Excludes Happy Hour.)", id: "101")], continualDeal: "Save 10% Thereafter. (Dine-in only. Max 2 cards per table. Excludes Happy Hour.)", id: "20")
        merchants.append(merchant20)

        let merchant21 = AxxessMerchant(name: "Copenhagen Sausage Garden", address: "1660 Copenhagen Dr, Solvang, CA 93463", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Excludes charcuterie.)", id: "227")], continualDeal: "Save 10% Thereafter.", id: "21")
        merchants.append(merchant21)

        let merchant22 = AxxessMerchant(name: "Corazon Cocina SB", address: "38 W Victoria St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Taco or Quesadilla, Get One Free.", id: "312")], continualDeal: "Save 10% Thereafter.", id: "22")
        merchants.append(merchant22)

        let merchant23 = AxxessMerchant(name: "Country Meat Market & Catering", address: "5925 Calle Real, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Deli Sandwich, Get One 50% Off.", id: "255"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Burger, Get One Free.", id: "254")], continualDeal: "Buy $40 Worth of Meat, Get a Free Pound of Ground Beef. Everytime! (Excludes deli meat, sale items & special orders.)", id: "23")
        merchants.append(merchant23)

        let merchant24 = AxxessMerchant(name: "Crushcakes & Cafe, Anacapa", address: "1315 Anacapa St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Excludes catering, wedding & delivery.)", id: "12")], continualDeal: "Save 10% on Entrees & Cupcakes Thereafter. (Excludes catering, wedding & delivery.)", id: "24")
        merchants.append(merchant24)

        let merchant25 = AxxessMerchant(name: "Crushcakes & Cafe, Carpinteria", address: "4945 Carpinteria Ave, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Excludes catering, wedding & delivery.)", id: "15")], continualDeal: "Save 10% on Entrees & Cupcakes Thereafter. (Excludes catering, wedding & delivery.)", id: "25")
        merchants.append(merchant25)

        let merchant26 = AxxessMerchant(name: "Crushcakes & Cafe, Goleta", address: "5392 Hollister Ave, Goleta, CA 93111", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Excludes catering, wedding & delivery.)", id: "230")], continualDeal: "Save 10% on Entrees & Cupcakes Thereafter. (Excludes catering, wedding & delivery.)", id: "26")
        merchants.append(merchant26)

        let merchant27 = AxxessMerchant(name: "Davy's Stable Cafe", address: "4600 Highway 154, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "195")], continualDeal: "Save 10% Thereafter. (Excludes alcohol.)", id: "27")
        merchants.append(merchant27)

        let merchant28 = AxxessMerchant(name: "Dawn Patrol Cafe", address: "324 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "339")], continualDeal: "Save 10% Thereafter.", id: "28")
        merchants.append(merchant28)

        let merchant29 = AxxessMerchant(name: "Del Pueblo Cafe", address: "5134 Hollister Ave, Goleta, CA 93111", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "183")], continualDeal: "Free Soft Drink with Entree Purchase Thereafter.", id: "29")
        merchants.append(merchant29)

        let merchant30 = AxxessMerchant(name: "Discovery Ventura", address: "1888 E Thompson Blvd, Ventura, CA 93001", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "275"), AxxessOneTimeDeal(oneTimeDealDescription: "One Free Game of Bowling. (Up to 1 hour per group.)", id: "213")], continualDeal: "Save 10% Thereafter. (Dining)", id: "30")
        merchants.append(merchant30)
        
        return merchants
    }

}

