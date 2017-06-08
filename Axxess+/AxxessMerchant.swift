//
//  AxxessMerchant.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

class AxxessMerchant: NSCoding {
    let name: String
    let address: String
    let oneTimeDeal: String
    let continualDeal: String

    init(name: String, address: String, oneTimeDeal: String, continualDeal: String) {
        self.name = name
        self.address = address
        self.oneTimeDeal = oneTimeDeal
        self.continualDeal = continualDeal
    }

    //MARK: NSCoding

    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let address = decoder.decodeObject(forKey: "address") as? String,
            let oneTimeDeal = decoder.decodeObject(forKey: "oneTimeDeal") as? String,
            let continualDeal = decoder.decodeObject(forKey: "continualDeal") as? String
            else {return nil}

        self.init(name: name, address: address, oneTimeDeal: oneTimeDeal, continualDeal: continualDeal)

    }

    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.address, forKey: "address")
        coder.encode(self.oneTimeDeal, forKey: "oneTimeDeal")
        coder.encode(self.continualDeal, forKey: "continualDeal")
    }

}
