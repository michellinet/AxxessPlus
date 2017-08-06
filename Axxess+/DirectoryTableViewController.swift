//
//  DirectoryTableViewController.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/15/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import CoreData

class DirectoryTableViewController: UITableViewController {
    private var merchants: [Merchant] = []
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DirectoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Merchant")

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44

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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let merchant = merchants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Merchant", for: indexPath) as! DirectoryTableViewCell
        cell.name.text = merchant.value(forKeyPath: "name") as? String
        cell.address.text = merchant.value(forKeyPath: "address") as? String
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
            let nextScene = segue.destination as? MerchantDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let selectedMerchant = merchants[indexPath.row]
            nextScene.currentMerchant = selectedMerchant
        }
    }

}
