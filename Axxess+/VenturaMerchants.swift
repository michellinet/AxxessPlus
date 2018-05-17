//
//  VenturaMerchants.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/16/18.
//  Copyright © 2018 Michelline Tran. All rights reserved.
//

import Foundation

//func setupAxxessMerchants() {
//    let managedContext = persistentContainer.viewContext
//    let merchantsForCurrentVersion = getMerchantsForCurrentVersion(context: managedContext)
//    for merchant in merchantsForCurrentVersion {
//        Merchant.findOrCreateMerchant(matching: merchant, in: managedContext)
//    }
//}
//
//func getMerchantsForCurrentVersion(context: NSManagedObjectContext) -> [AxxessMerchant] {
//    var merchants = [AxxessMerchant]()
//
//    let merchant1 = AxxessMerchant(name: "Altamirano's Mexican Grill", address: "5838 Hollister Ave, Goleta, CA 93117", oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value: $10. Dine in only.)", id: "23")], continualDeal: "Save 10% Thereafter.", id: "1")
//    merchants.append(merchant1)
//
//    return merchants
//}
//
//
struct VenturaMerchants {
    let merchant1 = AxxessMerchant(name: "805 Bar & Grilled Cheese", address: "1575 Spinnaker Drive, Ventura, CA 93001",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "1")],
                                   continualDeal: "Save 10% Thereafter.", id: "1")

    let merchant2 = AxxessMerchant(name: "Agave Maria's Restaurant", address: "710 Arneill Rd, Camarillo, CA 93010",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "2")],
                                   continualDeal: "Save 10% Thereafter.", id: "2")

    let merchant3 = AxxessMerchant(name: "Aloha Steakhouse", address: "364 S. Calfornia St, Ventura, CA 93001",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Save $8 on Any Two Dinner Entrees. (Valid Sun-Thurs)", id: "3"), AxxessOneTimeDeal(oneTimeDealDescription: "Save $4 on Any Two Lunch Entrees.", id: "4")],
                                   continualDeal: "Free Hula Pie with Any Two Entrees Thereafter.", id: "3")

    let merchant4 = AxxessMerchant(name: "Anacapa Brewing Company", address: "472 E Main St, Ventura, CA 93001",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree Get One Free.", id: "5")],
                                   continualDeal: "Save 15% Thereafter.", id: "4")

    let merchant5 = AxxessMerchant(name: "Austen's at The Pierpont", address: "550 Sanjon Rd, Ventura, CA 93001",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Dinner Entree, Get One 50% Off.", id: "6"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Breakfast or Lunch Entree, Get One Free", id: "7")],
                                   continualDeal: "Save 10% Thereafter.", id: "5")

    let merchant6 = AxxessMerchant(name: "Bad Ass Tacos", address: "2951 Thousand Oaks Blvd, Thousand Oaks, CA 91362",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "8")],
                                   continualDeal: "Save 10% Thereafter.", id: "6")

    let merchant7 = AxxessMerchant(name: "Bandits' Grill & Bar", address: "1980 Ventura Blvd, Camarillo, CA 93010",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get 50% Off. (Dine-in & Camarillo location only.)", id: "9")],
                                   continualDeal: "Save 10% Thereafter.", id: "7")

    let merchant8 = AxxessMerchant(name: "Barrelhouse 101", address: "545 E Thompson Blvd, Ventura, CA 93001",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "10"), AxxessOneTimeDeal(oneTimeDealDescription: "2-for-1 Regular Beer Sampler.", id: "11")],
                                   continualDeal: "Save 10% Thereafter.", id: "8")

    let merchnat9 = AxxessMerchant(name: "Basil & Mint Vietnamese Cafe", address: "350 N Lantana St., #7, Camarillo, CA 93010 ",
                                   oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "12")],
                                   continualDeal: "Save 10% Thereafter.", id: "9")

    let merchant11 = AxxessMerchant(name: "BG's Cafe", address: "428 S. A St., Oxnard, CA 93030",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "14")],
                                    continualDeal: "Save 15% Thereafter.", id: "11")

    let merchant13 = AxxessMerchant(name: "BLVD BRGR Co.", address: "2145 Ventura Blvd., Camarillo, CA 93010",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "16")],
                                    continualDeal: "Save 10% Thereafter.", id: "13")

    let merchant14 = AxxessMerchant(name: "Bombay Bar & Grill", address: "143 S. California St, Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Excludes Happy Hour)", id: "17")],
                                    continualDeal: "Save 10% Thereafter.", id: "14")

    let merchant16 = AxxessMerchant(name: "Bonnie Lu's", address: "328 E. Ojai Ave., Ojai, CA 93023",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "19")],
                                    continualDeal: "Save 10% Thereafter.", id: "16")

    let merchant17 = AxxessMerchant(name: "Busy Bee Cafe", address: "478 E. Main St., Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One 50% Off.", id: "20")],
                                    continualDeal: "Save 10% Thereafter. Buy Two Entrees, Get a Free Appetizer or Dessert.", id: "17")

    let merchant18 = AxxessMerchant(name: "Cafe Fiore", address: "66 California St., Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.(Max Value $25)", id: "21")],
                                    continualDeal: "Save 15% Thereafter. (Exclude Happy Hour", id: "18")

    let merchant19 = AxxessMerchant(name: "Cafe India", address: "1775 E Daily Dr, Camarillo, CA 93010",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Max Value $10. Dinner Only.)", id: "22")],
                                    continualDeal: "Save 15% Thereafter OR Save $1 on Lunch Buffet.", id: "19")

    let merchant21 = AxxessMerchant(name: "Casa de Lago, Ojai", address: "715 E Ojai Ave, Ojai, CA 93023",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Dine-in only.)", id: "24")],
                                    continualDeal: "Save 10% Thereafter.", id: "21")

    let merchant22 = AxxessMerchant(name: "Charley's Philly Steaks", address: "740 Ventura Blvd, Suite FC2, Camarillo, CA 93010",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Philly Cheese Steak, Get One Free.", id: "25")],
                                    continualDeal: "Buy One Philly Cheese Steak, Get One 50% Off.", id: "22")

    let merchant23 = AxxessMerchant(name: "Ciao Italian Grill", address: "1111 S Victoria Ave, Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "26")],
                                    continualDeal: "Save 10% Thereafter.", id: "23")

    let merchant24 = AxxessMerchant(name: "CJ's BBQ, Oxnard", address: "480 S Victoria Ave #B, Oxnard, CA 93030",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "27")],
                                    continualDeal: "Save 15% Thereafter.", id: "24")

    let merchant25 = AxxessMerchant(name: "CJ's BBQ, Ventura", address: "1708B S Victoria Ave, Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free.", id: "28")],
                                    continualDeal: "Save 15% Thereafter.", id: "25")

    let merchant26 = AxxessMerchant(name: "Coconut Crab, Simi Valley", address: "1555 Simi Valley Town Center Way, Simi Valley, CA 93065",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Boiled Bag or Pan Roast, Get One 50% Off. (Excludes lobster & crab.)", id: "29"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Excldues boiled bags and pan roasts.)", id: "30")],
                                    continualDeal: "Save 10% Thereafter. (Excludes alcohol.)", id: "26")

    let merchant27 = AxxessMerchant(name: "Coconut Crab, Ventura", address: "394 E Main St, Ventura, CA 93001",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Boiled Bag or Pan Roast, Get One 50% Off. (Excludes lobster & crab.)", id: "31"), AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Excldues boiled bags and pan roasts.)", id: "32")],
                                    continualDeal: "Save 10% Thereafter. (Excludes alcohol.)", id: "27")

    let merchant28 = AxxessMerchant(name: "Copper Blues", address: "591 Collections Blvd, Oxnard, CA 93036",
                                    oneTimeDeals: [AxxessOneTimeDeal(oneTimeDealDescription: "Buy One Entree, Get One Free. (Lunch Specials Excluded)", id: "33")], continualDeal: "Save 10% Thereafter.", id: "28")

}

