//
//  DirectoryTableViewController.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/15/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import CoreData

class DirectoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    private var merchants: [Merchant] = []

    let searchController = UISearchController(searchResultsController: nil)

    var filteredMerchants = [Merchant]()

    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    fileprivate var fetchedResultsController: NSFetchedResultsController<Merchant>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DirectoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Merchant")

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Merchant> = Merchant.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        // Create Fetched Results Controller
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.container!.viewContext,
            sectionNameKeyPath: nil, cacheName: nil
        )

        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.localizedDescription)")
        }

        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let merchants = fetchedResultsController.fetchedObjects else { return 0 }
        return merchants.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let merchant = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Merchant", for: indexPath) as! DirectoryTableViewCell

        cell.name.text = merchant.value(forKeyPath: "name") as? String
        cell.address.text = merchant.value(forKeyPath: "address") as? String
        if merchant.checkAvailableOneTimeDeals() == 0 {
            cell.dealIndicatorView.isHidden = true
        } else {
            cell.dealIndicatorView.isHidden = false
            cell.dealCount.text = "\(merchant.checkAvailableOneTimeDeals())"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
            let nextScene = segue.destination as? MerchantDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let selectedMerchant = fetchedResultsController.object(at: indexPath)
            nextScene.currentMerchant = selectedMerchant
        }
    }

    //MARK: NSFetchedResultsControllerDelegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .update:
            if let indexPath = indexPath, let merchant = anObject as? Merchant {
                let cell = tableView.cellForRow(at: indexPath) as! DirectoryTableViewCell
                if merchant.checkAvailableOneTimeDeals() == 0 {
                    cell.dealIndicatorView.isHidden = true
                } else {
                    cell.dealIndicatorView.isHidden = false
                    cell.dealCount.text = "\(merchant.checkAvailableOneTimeDeals())"
                }
            }
        default:
            print("")
        }
    }

}

extension DirectoryTableViewController: UISearchResultsUpdating {
    //MARK: UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            let fetchRequest: NSFetchRequest<Merchant> = Merchant.fetchRequest()

            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

            if searchText != "" {
                let filterPredicate = NSPredicate(format: "(name CONTAINS[c] %@) OR (%@ IN oneTimeDeals.id)", searchText, searchText)
                fetchRequest.predicate = filterPredicate
            }

            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.container!.viewContext, sectionNameKeyPath: nil, cacheName: nil)

            do {
                try fetchedResultsController.performFetch()
            } catch let error as NSError {
                print("Couldn't fetch. \(error), \(error.localizedDescription)")
            }

            tableView.reloadData()
        }
    }
}
