//
//  AxxessMerchant.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

struct AxxessMerchant {
    let name: String
    let address: String
    let oneTimeDeals: [AxxessOneTimeDeal]
    let continualDeal: String
    let id: String
}

struct AxxessOneTimeDeal {
    let oneTimeDealDescription: String
    let id: String
}
