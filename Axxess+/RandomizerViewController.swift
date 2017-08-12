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
    @IBOutlet weak var randomMerchantView: UIView!
    @IBOutlet weak var randomMerchantNameLabel: UILabel!
    @IBOutlet weak var numberOfDealsActiveLabel: UILabel!
    @IBOutlet weak var seeDetailsButton: UIButton!
    
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
        // Set up animation with a clean card.
        randomMerchantNameLabel.text = ""
        numberOfDealsActiveLabel.text = ""

        // Animate and complete with populating randomMerchant details.
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
            self.randomMerchantView.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 0, 1, 0)
            self.randomMerchantView.alpha = 0
            self.seeDetailsButton.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.randomMerchantView.layer.transform = CATransform3DIdentity
                self.randomMerchantView.alpha = 1.0
            }, completion: { (_) in
                self.randomMerchant = self.findRandomMerchant()
                let randomMerchantDealsCount = self.randomMerchant.checkAvailableOneTimeDeals()
                self.randomMerchantNameLabel.text = self.randomMerchant.value(forKey: "name") as? String

                if randomMerchantDealsCount == 1 {
                    self.numberOfDealsActiveLabel.text = "\(randomMerchantDealsCount) Deal Active"
                } else {
                    self.numberOfDealsActiveLabel.text = "\(randomMerchantDealsCount) Deals Active"
                }
                self.seeDetailsButton.alpha = 1.0
            })
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
