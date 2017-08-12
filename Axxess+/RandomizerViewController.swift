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

    private var merchants: [Merchant] = []
    private var randomMerchant = Merchant()

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

    // Segues to merchant details view if `See Details` is pressed.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue", let nextScene = segue.destination as? MerchantDetailViewController {
            nextScene.currentMerchant = randomMerchant
        }
    }

    @IBAction func tellMeWhatToEatPressed(_ sender: Any) {
        // Use random merchant's details to update view.
        randomMerchant = findRandomMerchant()
        let randomMerchantDealsCount = randomMerchant.checkAvailableOneTimeDeals()
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

    func findRandomMerchant() -> Merchant {
        // Find merchants with at least 1 deal available.
        var merchantsWithActiveDeal = [Merchant]()
        for merchant in merchants {
            if merchant.checkAvailableOneTimeDeals() > 0 {
                merchantsWithActiveDeal.append(merchant)
            }
        }

        // Pick a random merchant from the array of merchants with deal(s).
        let randomIndex = random(merchantsWithActiveDeal.count - 1)
        randomMerchant = merchantsWithActiveDeal[randomIndex]
        return randomMerchant
    }
}
