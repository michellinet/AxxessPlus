//
//  MerchantDetailViewController.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/19/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MerchantDetailViewController: UIViewController, MKMapViewDelegate {
    private var merchants: [NSManagedObject] = []

    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantAddress: UILabel!
    @IBOutlet weak var merchantOneTimeDeal: UILabel!
    @IBOutlet weak var merchantContinualDeal: UILabel!

    @IBAction func dismissMerchantDetails(_ sender: Any) {

        navigationController?.popViewController(animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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

    @IBOutlet weak var merchantMapView: MKMapView!
    var annotation: MKPointAnnotation?

    func setupMKView (address: String, MKView: MKMapView) {
        if let existingAnnotation = self.annotation {
            MKView.removeAnnotation(existingAnnotation)
        }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarkArray, error) in
            if (error != nil) { return }
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

    var currentMerchant: Merchant?

    func configureView() {
        if let merchant = currentMerchant {
            merchantName.text = merchant.name
            merchantAddress.text = merchant.address
            merchantOneTimeDeal.text = merchant.oneTimeDeal
            merchantContinualDeal.text = merchant.continualDeal

            if let address = merchantAddress.text {
                setupMKView(address: address, MKView: merchantMapView)
            }
        }
    }
}
