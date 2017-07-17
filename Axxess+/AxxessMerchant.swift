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
    let id: String

    init(name: String, address: String, oneTimeDeal: String, continualDeal: String, id: String) {
        self.name = name
        self.address = address
        self.oneTimeDeal = oneTimeDeal
        self.continualDeal = continualDeal
        self.id = id
    }
    


    //MARK: NSCoding

    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let address = decoder.decodeObject(forKey: "address") as? String,
            let oneTimeDeal = decoder.decodeObject(forKey: "oneTimeDeal") as? String,
            let continualDeal = decoder.decodeObject(forKey: "continualDeal") as? String,
            let id = decoder.decodeObject(forKey: "id") as? String
            else {return nil}

        self.init(name: name, address: address, oneTimeDeal: oneTimeDeal, continualDeal: continualDeal, id: id)

    }

    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.address, forKey: "address")
        coder.encode(self.oneTimeDeal, forKey: "oneTimeDeal")
        coder.encode(self.continualDeal, forKey: "continualDeal")
        coder.encode(self.id, forKey: "id")
    }

}
