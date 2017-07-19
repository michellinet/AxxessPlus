//
//  AxxessMerchant.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

class AxxessMerchant {
    let name: String
    let address: String
    let oneTimeDeal: String
    let continualDeal: String
    let id: String

    init(name: String, address: String, oneTimeDeal: String, continualDeal: String, id: String) {
        self.name = name
        self.address = address
        self.oneTimeDeal = oneTimeDeal
        self.continualDeal = continualDeal
        self.id = id
    }
}
