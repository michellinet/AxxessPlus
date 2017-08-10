//
//  RandomizerViewController.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class RandomizerViewController: UIViewController {
    
    @IBOutlet weak var randomMerchantNameLabel: UILabel!
    @IBOutlet weak var numberOfDealsActiveLabel: UILabel!
    @IBOutlet weak var seeDetailsButton: UIButton!

    private var merchants: [Merchant] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Merchant>(entityName: "Merchant")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]

        do {
            merchants = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }

    @IBAction func tellMeWhatToEatPressed(_ sender: Any) {
        // Find a random merchant with minimum 1 deal available.
        var merchantsWithActiveDeal = [Merchant]()
        for merchant in merchants {
            if merchant.checkAvailableOneTimeDeals() > 0 {
                merchantsWithActiveDeal.append(merchant)
            }
        }
        let randomIndex = random(merchantsWithActiveDeal.count - 1)
        let randomMerchant = merchantsWithActiveDeal[randomIndex]
        let randomMerchantDealsCount = randomMerchant.checkAvailableOneTimeDeals()
       
        // Use random merchant's details to update view.
        randomMerchantNameLabel.text = randomMerchant.value(forKey: "name") as? String
        if randomMerchantDealsCount == 1 {
            numberOfDealsActiveLabel.text = "\(randomMerchantDealsCount) Deal Active"
        } else {
            numberOfDealsActiveLabel.text = "\(randomMerchantDealsCount) Deals Active"
        }
    }
    
    //MARK: Helpers
    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
}
