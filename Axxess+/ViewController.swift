//
//  ViewController.swift
//  Axxess+
//
//  Created by Michelline Tran on 5/31/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var merchantList: [AxxessMerchant]!
    
    func setupMerchantList() {
        let merchantOne = AxxessMerchant(name: "TAP Thai Cuisine", address: "3130 State St., Santa Barbara, CA 93105", oneTimeDeal: "Buy One Entree, Get One Free.", continualDeal: "Save 10% Thereafter.")
        let merchantTwo = AxxessMerchant(name: "Live Oak Cafe", address: "2220 Bath St., Santa Barbara, CA 93105", oneTimeDeal: "Buy One Entree, Get One Free.", continualDeal: "Save 10% Thereafter.")
        let merchantThree = AxxessMerchant(name: "Los Agaves - De La Vina", address: "2911 De La Vina St., Santa Barbara, CA 93105", oneTimeDeal: "Buy One Entree, Get One Free.", continualDeal: "Free Fountain Drink with Entree Purchase Thereafter.")
        merchantList = []
        merchantList.append(contentsOf: [merchantOne,merchantTwo, merchantThree])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMerchantList()
        merchantMapView.delegate = self
    }
    @IBAction func tellMeWhatToEatPressed(_ sender: Any) {
        let randomIndex = Int(arc4random() % 3)
        let randomMerchant = merchantList[randomIndex]
        
        merchantName.text = randomMerchant.name
        merchantAddress.text = randomMerchant.address
        merchantOneTimeDeal.text = randomMerchant.oneTimeDeal
        merchantContinualDeal.text = randomMerchant.continualDeal
        
        setupMKView(address: randomMerchant.address, MKView: merchantMapView)
    }

    @IBOutlet weak var merchantName: UILabel!
    
    @IBOutlet weak var merchantAddress: UILabel!
    
    @IBOutlet weak var merchantMapView: MKMapView!
    
    var annotation: MKPointAnnotation?
    
    func setupMKView (address: String, MKView: MKMapView) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarkArray, error) in
            if (error != nil) {
                return
            }
            
            if let placemark = placemarkArray?.first, let location = placemark.location {
                //MKView.setCenter(location.coordinate, animated: true)
                let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpanMake(1/69, 1/69))
                MKView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                MKView.showAnnotations([annotation], animated: true)
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

