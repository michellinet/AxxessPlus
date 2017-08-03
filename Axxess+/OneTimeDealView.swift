//
//  OneTimeDealView.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/26/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import UIKit

class OneTimeDealView: UIView {
    @IBOutlet weak var usedIndicator: UIImageView!
    @IBOutlet weak var dealNumber: UILabel!
    @IBOutlet weak var dealDescription: UILabel!
    @IBOutlet weak var dealActiveSwitch: UISwitch!

    var deal: OneTimeDeal

    init(deal: OneTimeDeal) {
        self.deal = deal
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 105 ) )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func updateView() {
        if deal.id != "" {
            dealNumber.text = deal.id
        } else {
            dealNumber.isHidden = true
        }

        if deal.used {
            usedIndicator.image = #imageLiteral(resourceName: "discount-grey")
        } else {
            usedIndicator.image = #imageLiteral(resourceName: "discount-purple")
        }

        dealDescription.text = deal.oneTimeDealDescription
    }
}
