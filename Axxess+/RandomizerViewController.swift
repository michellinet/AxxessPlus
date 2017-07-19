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

class RandomizerViewController: UIViewController, MKMapViewDelegate {

    private var merchants: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        merchantMapView.delegate = self

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Merchant")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]

        do {
            merchants = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }

    @IBAction func tellMeWhatToEatPressed(_ sender: Any) {
        let randomIndex = Int(arc4random() % 3)
        let randomMerchant = merchants[randomIndex]


        merchantName.text = randomMerchant.value(forKey: "name") as? String
        merchantAddress.text = randomMerchant.value(forKey: "address") as? String
        merchantOneTimeDeal.text = randomMerchant.value(forKey: "oneTimeDeal") as? String
        merchantContinualDeal.text = randomMerchant.value(forKey: "continualDeal") as? String

        if let address = merchantAddress.text {
            setupMKView(address: address, MKView: merchantMapView)
        }
    }

    @IBOutlet weak var merchantName: UILabel!
    
    @IBOutlet weak var merchantAddress: UILabel!
    
    @IBOutlet weak var merchantMapView: MKMapView!
    
    var annotation: MKPointAnnotation?
    
    func setupMKView (address: String, MKView: MKMapView) {

        if let existingAnnotation = self.annotation {
            MKView.removeAnnotation(existingAnnotation)
        }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarkArray, error) in
            if (error != nil) {
                return
            }
            
            if let placemark = placemarkArray?.first, let location = placemark.location {
                let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpanMake(1/69, 1/69))
                MKView.setRegion(region, animated: true)
                
                let newAnnotation = MKPointAnnotation()
                self.annotation = newAnnotation
                newAnnotation.coordinate = location.coordinate
                MKView.showAnnotations([newAnnotation], animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView()
        pin.pinTintColor = UIColor(red: 77/255.0, green: 21/255.0, blue: 186/255.0, alpha: 1)
        return pin
    }
    
    @IBOutlet weak var merchantOneTimeDeal: UILabel!

    @IBOutlet weak var merchantContinualDeal: UILabel!
}

