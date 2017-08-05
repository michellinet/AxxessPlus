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

    var deal: OneTimeDeal!
    
    class func createOneTimeDealView(deal: OneTimeDeal) -> OneTimeDealView {
        let nib = UINib(nibName: "OneTimeDealView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! OneTimeDealView
        nib.deal = deal
        nib.updateView()
        return nib
    }
    
    func showToggle(hidden: Bool) {
        dealActiveSwitch.isHidden = hidden
    }

    @IBAction func switchWasToggled(_ sender: Any) {
        if dealActiveSwitch.isOn {
           usedIndicator.image = #imageLiteral(resourceName: "discount-purple")
        } else {
            usedIndicator.image = #imageLiteral(resourceName: "discount-grey")
        }
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
