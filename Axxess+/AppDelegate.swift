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
       
        let merchant1 = AxxessMerchant(name: "Altamirano's Mexican Grill", address: "5838 Hollister Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. Dine in only.)", id: "23")], continualDeal: "Save 10% Thereafter.", id: "1")
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
        let merchant8 = AxxessMerchant(name: "Cajun Kitchen", address: "1924 De La Vina St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Espresso Drink, Get One Free OR Free Espresso Drink with Purchase of Entree. (Max 2 cards per table.)", id: "174")], continualDeal: "No Continual Deal.", id: "8")
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

        let merchant16 = AxxessMerchant(name: "China Pavillion", address: "1202 Chapala St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $15. Valid for dine-in & take out orders. Limit 1 per table. Excludes Chinese New Year & all holidays.)", id: "44")], continualDeal: "Save 10% Thereafter. (Max value $15. Valid for dine-in & take out orders. Limit 1 per table. Excludes Chinese New Year & all holidays.)", id: "16")
        merchants.append(merchant16)

        let merchant17 = AxxessMerchant(name: "CHOMP", address: "1693 Mission Dr, Solvang, CA 93463", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "77")], continualDeal: "", id: "17")
        merchants.append(merchant17)

        let merchant18 = AxxessMerchant(name: "Chuck's Waterfront Grill", address: "113 Harbor Way, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Not valid with other offers, specials or promotions. 1 card per party/table.)", id: "173")], continualDeal: "Save $7 on the Purchase of Two Dinner Entrees. Everytime! (Not valid with other offers, specials or promotions. 1 card per party/table.)", id: "18")
        merchants.append(merchant18)

        //no continual
        let merchant19 = AxxessMerchant(name: "Cody's Cafe", address: "4898 Hollister Ave, Santa Barbara, CA 93111", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "74")], continualDeal: "No Continual Deal.", id: "19")
        merchants.append(merchant19)

        let merchant20 = AxxessMerchant(name: "Convino", address: "901 E Cabrillo Blvd, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Food Item, Get One Free. (Max Value: $20. Dine-in only. Max 2 cards per table. Excludes Happy Hour.)", id: "101")], continualDeal: "Save 10% Thereafter. (Dine-in only. Max 2 cards per table. Excludes Happy Hour.)", id: "20")
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

        //no one-time
        let merchant31 = AxxessMerchant(name: "Edomasa", address: "2710 De La Vina St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "No One-Time Deals.", id: "")], continualDeal: "Save 10%. Everytime! (Excludes beverages. Not valid on to-go orders. Card must be provided before payment. One card per table.)", id: "31")
        merchants.append(merchant31)

        let merchant32 = AxxessMerchant(name: "El Pollo Loco, Goleta", address: "5796 Calle Real, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "208")], continualDeal: "Save 10% Thereafter.", id: "32")
        merchants.append(merchant32)

        let merchant33 = AxxessMerchant(name: "El Pollo Loco, Santa Barbara", address: "2984 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "207")], continualDeal: "Save 10% Thereafter.", id: "33")
        merchants.append(merchant33)

        let merchant34 = AxxessMerchant(name: "El Rincon Bohemio", address: "4141 State St, Santa Barbara, CA 93110", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $8. Not valid Sunday 8am-2pm. Dine-in only.)", id: "374")], continualDeal: "Save 10% Thereafter.", id: "34")
        merchants.append(merchant34)

        let merchant35 = AxxessMerchant(name: "El Zarape", address: "1435 San Andres St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "55")], continualDeal: "Save 10% Thereafter.", id: "35")
        merchants.append(merchant35)

        let merchant36 = AxxessMerchant(name: "Eladio's Restaurant & Bar", address: "1 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (One per table. Dine-in only.)", id: "169")], continualDeal: "Save 10% Thereafter.", id: "36")
        merchants.append(merchant36)

        let merchant37 = AxxessMerchant(name: "Empress Palace", address: "2251 Las Positas Rd, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $15.)", id: "252"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy Two Sushi Rolls, Get One Free. (Max Value: $12.95.)", id: "240")], continualDeal: "Save 25% Mon-Thurs Thereafter. Save 10% Fri-Sunday Thereafter. (Delivery & online orders excluded.)", id: "37")
        merchants.append(merchant37)

        let merchant38 = AxxessMerchant(name: "Endless Summer", address: "113 Harbor Way, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Valid for lunch until 4pm. Not valid with other offers, specials or promotions.)", id: "189")], continualDeal: "Save $5 on the Purchase of Two Entrees. Everytime! (Not valid with other offers, specials or promotions. 1 card per party/table.)", id: "38")
        merchants.append(merchant38)

        let merchant39 = AxxessMerchant(name: "Enterprise Fish Company", address: "225 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Lunch Entree, Get One 50% Off.", id: "276")], continualDeal: "Free Appetizer with Purchase of Two Entrees Thereafter. (Max Value: $9.)", id: "39")
        merchants.append(merchant39)

        let merchant40 = AxxessMerchant(name: "Finch & Fork", address: "31 W Carrillo St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy Two Entrees, Get a Free Appetizer. (Max Value: $16. Excludes raw bar items.)", id: "3")], continualDeal: "Buy Two Cocktails, Beers or Glasses of Wine & Save 50% on One Appetier. Everytime! (Valid in the bar/lounge area only. Excludes Happy Hour.)", id: "40")
        merchants.append(merchant40)

        let merchant41 = AxxessMerchant(name: "Galanga Authentic Thai Cuisine", address: "507 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. One Axxess card per party.)", id: "166")], continualDeal: "Save 10% Thereafter. (Max Value: $15)", id: "41")
        merchants.append(merchant41)

        let merchant42 = AxxessMerchant(name: "The Garden Market", address: "3811 Santa Claus Ln, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $9)", id: "256")], continualDeal: "Save 10% Thereafter. Save 10% on Events. (Excludes merchandise.)", id: "42")
        merchants.append(merchant42)

        let merchant43 = AxxessMerchant(name: "Giovanni's Pizza, Carpinteria", address: "5003 Carpinteria Ave, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Pizza, Get the 2nd Half Off.", id: "124")], continualDeal: "Save 10% Thereafter.", id: "43")
        merchants.append(merchant43)

        let merchant44 = AxxessMerchant(name: "Giovanni's Pizza, Mesa", address: "1905 Cliff Dr, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Save 50% on Your First Pizza or Lunch Special. (Valid at Mesa or State St Location.)", id: "153")], continualDeal: "Save 10% Thereafter.", id: "44")
        merchants.append(merchant44)

        let merchant45 = AxxessMerchant(name: "Giovanni's Pizza, Montecito", address: "1187 Coast Village Rd, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Pizza, Get the 2nd Half Off.", id: "123")], continualDeal: "Save 10% Thereafter.", id: "45")
        merchants.append(merchant45)

        let merchant46 = AxxessMerchant(name: "Giovanni's Pizza, State St", address: "3020 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "See 'Giovanni's Pizza, Mesa' one-time deal.", id: "")], continualDeal: "Save 10% Thereafter.", id: "46")
        merchants.append(merchant46)

        let merchant47 = AxxessMerchant(name: "Global Gardens", address: "2477 Alamo Pintado, Los Olivos, CA 93441", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "2 Free Tastings!", id: "214")], continualDeal: "Free Organic Appetizer Spread with Club Sign-up Everytime!", id: "47")
        merchants.append(merchant47)

        let merchant48 = AxxessMerchant(name: "Goodland Kitchen", address: "231 S Magnolia Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "245")], continualDeal: "$1 Cookie, Lemonade or Iced Tea Thereafter.", id: "48")
        merchants.append(merchant48)

        let merchant49 = AxxessMerchant(name: "Green Table", address: "113 W De La Guerra St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Matcha, or Any Food Item, Get One Free. (Excludes cleanses.)", id: "2")], continualDeal: "Save 10% Thereafter.", id: "49")
        merchants.append(merchant49)

        let merchant50 = AxxessMerchant(name: "Hibachi Steak House & Sushi Bar", address: "502 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "No One Time Deals", id: "")], continualDeal: "Save 10% on Hibachi Entrees Only After 5pm. (Max Value: $25. Excludes alcohol & sushi. Not valid on holidays or graduation.)", id: "50")
        merchants.append(merchant50)

        let merchant51 = AxxessMerchant(name: "High Sierra Grill House", address: "521 Firestone Rd, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Breakfast Entree, Get One Free. (Valid 7am-11am.)", id: "371"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Lunch or Dinner Entree, Get One Free. (Max Value: $17)", id: "338")], continualDeal: "Save 20% on Breakfast (7am-11am). Save 10% on Lunch & Dinner.", id: "51")
        merchants.append(merchant51)

        let merchant52 = AxxessMerchant(name: "Himalayan Kitchen", address: "431 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Save $5 off $30+ OR Save $10 off $50+ OR Save $20 off $100+. (Not valid on delivery.)", id: "244")], continualDeal: "Save 10% on Orders Thereafter. (Not valid on delivery.)", id: "52")
        merchants.append(merchant52)

        let merchant53 = AxxessMerchant(name: "Ichiban Japanese Restaurant", address: "1812 Cliff Dr, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Roll, Get One Free. (Max Value: $8. Limit One Per Table.)", id: "246")], continualDeal: "Save 10% Thereafter.", id: "53")
        merchants.append(merchant53)

        let merchant54 = AxxessMerchant(name: "IHOP, Carpinteria", address: "1114 Casitas Pass Rd, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. Excludes holidays.)", id: "154")], continualDeal: "Save 10% Thereafter.", id: "54")
        merchants.append(merchant54)

        let merchant55 = AxxessMerchant(name: "IHOP, Goleta", address: "4765 Calle Real, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. Excludes holidays.)", id: "147")], continualDeal: "Save 10% Thereafter.", id: "55")
        merchants.append(merchant55)

        let merchant56 = AxxessMerchant(name: "IHOP, Santa Barbara", address: "1701 State St, Santa Barabara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. Excludes holidays.)", id: "151")], continualDeal: "Save 10% Thereafter.", id: "56")
        merchants.append(merchant56)

        let merchant57 = AxxessMerchant(name: "Jack's Bistro, Carpinteria", address: "5050 Carpinteria Ave, Carpinteria, CA 93013", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Breakfast or Lunch Entree, Get One 50% Off.", id: "224")], continualDeal: "Save 10% Thereafter.", id: "57")
        merchants.append(merchant57)

        let merchant58 = AxxessMerchant(name: "Jack's Bistro, Santa Barbara", address: "53 S Milpas St, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Breakfast or Lunch Entree, Get One 50% Off.", id: "223")], continualDeal: "Save 10% Thereafter.", id: "58")
        merchants.append(merchant58)

        let merchant59 = AxxessMerchant(name: "Jersey Mike's, Downtown", address: "1213 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Regular Sub, Get One Free", id: "65")], continualDeal: "Save 10% Thereafter.", id: "59")
        merchants.append(merchant59)

        let merchant60 = AxxessMerchant(name: "Jersey Mike's, Goleta", address: "7034 Marketplace Dr, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Regular Sub, Get One Free", id: "7")], continualDeal: "Save 10% Thereafter.", id: "60")
        merchants.append(merchant60)

        let merchant61 = AxxessMerchant(name: "Jersey Mike's, Loreto Plaza", address: "3225 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Regular Sub, Get One Free", id: "78")], continualDeal: "Save 10% Thereafter.", id: "61")
        merchants.append(merchant61)

        let merchant62 = AxxessMerchant(name: "Kimchi Korean BBQ", address: "3132 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One All-You-Can-Eat Buffet, Get One Free.", id: "138")], continualDeal: "Save 10% Thereafter.", id: "62")
        merchants.append(merchant62)

        let merchant63 = AxxessMerchant(name: "Kyle's Kitchen, Goleta", address: "5723 Calle Real, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Burger or Salad, Get One Free. (Max Value: $8)", id: "369")], continualDeal: "Save 10% Thereafter.", id: "63")
        merchants.append(merchant63)

        let merchant64 = AxxessMerchant(name: "Kyle's Kitchen, Santa Barbara", address: "791 Chapala St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Burger or Salad, Get One Free. (Max Value: $8. Not valid for online orders.)", id: "304")], continualDeal: "Save 10% Thereafter. (Not valid for online orders.)", id: "64")
        merchants.append(merchant64)

        let merchant65 = AxxessMerchant(name: "La Colmena Restaurant", address: "217 N Milpas St, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $9)", id: "250")], continualDeal: "Save 10% Thereafter.", id: "65")
        merchants.append(merchant65)

        let merchant66 = AxxessMerchant(name: "Le Cafe Stella", address: "3302 McCaw Ave, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Max 2 cards per table.)", id: "40")], continualDeal: "Save 10% Thereafter.", id: "66")
        merchants.append(merchant66)

        let merchant67 = AxxessMerchant(name: "Live Oak Cafe", address: "2220 Bath St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "239")], continualDeal: "Save 10% Thereafter.", id: "67")
        merchants.append(merchant67)

        let merchant68 = AxxessMerchant(name: "Los Agaves Restaurant, De La Vina", address: "2911 De La Vina St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Excludes seafood & specials.)", id: "262")], continualDeal: "Free Fountain Drink with Entree Purchase Thereafter.", id: "68")
        merchants.append(merchant68)

        let merchant69 = AxxessMerchant(name: "Los Agaves Restaurant, Milpas", address: "600 N Milpas Rd, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off. (Excludes seafood & specials.)", id: "129")], continualDeal: "Free Fountain Drink with Entree Purchase Thereafter.", id: "69")
        merchants.append(merchant69)

        let merchant70 = AxxessMerchant(name: "Los Altos Restaurant", address: "318 N Milpas St, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "149")], continualDeal: "Save 10% on Catering & Company Parties. (Free delivery, min $25 order.) Save 10% Thereafter.", id: "70")
        merchants.append(merchant70)

        let merchant71 = AxxessMerchant(name: "Los Tarascos Bakery", address: "314 E Haley St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Valid for dine-in or take-out.)", id: "248")], continualDeal: "Save 10% Thereafter.", id: "71")
        merchants.append(merchant71)

        let merchant72 = AxxessMerchant(name: "Mandarin Palace", address: "3955 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "No One-Time Deals.", id: "")], continualDeal: "Free Egg Rolls and Save 10% with purchase of One Entree. Everytime! (One card per tabel or to-go order.)", id: "72")
        merchants.append(merchant72)

        let merchant73 = AxxessMerchant(name: "Max's Restaurant & Cucina", address: "3514 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $13. Dine-in only. One card per table.)", id: "155")], continualDeal: "Save 10% Thereafter. (Dine-in only.)", id: "73")
        merchants.append(merchant73)

        let merchant74 = AxxessMerchant(name: "McDonald's, Downtown", address: "1213 State St, Santa Barbara, CA 93101", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "345")], continualDeal: "Save 10% Thereafter", id: "74")
        merchants.append(merchant74)

        let merchant75 = AxxessMerchant(name: "McDonald's, Goleta", address: "146 S Fairview Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "341")], continualDeal: "Save 10% Thereafter", id: "75")
        merchants.append(merchant75)

        let merchant76 = AxxessMerchant(name: "McDonald's, Marketplace", address: "6900 Marketplace Dr, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "343")], continualDeal: "Save 10% Thereafter", id: "76")
        merchants.append(merchant76)

        let merchant77 = AxxessMerchant(name: "McDonald's, Mesa", address: "1906 Cliff Dr, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "346")], continualDeal: "Save 10% Thereafter", id: "77")
        merchants.append(merchant77)

        let merchant78 = AxxessMerchant(name: "McDonald's, Milpas", address: "29 N Milpas St, Santa Barbara, CA 93103", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "342")], continualDeal: "Save 10% Thereafter", id: "78")
        merchants.append(merchant78)

        let merchant79 = AxxessMerchant(name: "McDonald's, Uptown", address: "3940 State St, Santa Barbara, CA 93105", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One of Anything, Get One Free. (Includes Extra Value Meals!)", id: "344")], continualDeal: "Save 10% Thereafter", id: "79")
        merchants.append(merchant79)

        let merchant80 = AxxessMerchant(name: "Mesa Burger", address: "315 Meigs Rd, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Salad or Burger, Get One Free.", id: "326")], continualDeal: "Save 10% Thereafter.", id: "80")
        merchants.append(merchant80)

        //no continual
        let merchant81 = AxxessMerchant(name: "Mesa Cafe", address: "1972 Cliff Dr, Santa Barbara, CA 93109", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "73")], continualDeal: "No Continual Deals.", id: "81")
        merchants.append(merchant81)

        return merchants
    }

}

