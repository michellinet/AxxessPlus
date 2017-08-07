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
    @IBOutlet weak var merchantName: UILabel!
    @IBOutlet weak var merchantAddress: UILabel!
    @IBOutlet weak var merchantContinualDeal: UILabel!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var oneTimeDealsStackView: UIStackView!

    
// MARK: UIBarButtonItems
    
    private func updateBarButtonsForMode(editModeOn: Bool) {
        if editModeOn == true {
            leftBarButtonItem.title = "Cancel"
            leftBarButtonItem.style = .done
            leftBarButtonItem.action =  #selector(cancelButtonTapped(sender:))
            
            rightBarButtonItem.title = "Save"
            rightBarButtonItem.style = .plain
            rightBarButtonItem.action = #selector(saveButtonTapped(sender:))
        } else {
            leftBarButtonItem.title = "Done"
            leftBarButtonItem.style = .done
            leftBarButtonItem.action = #selector(doneButtonTapped(sender:))
            
            rightBarButtonItem.title = "Edit"
            rightBarButtonItem.style = .plain
            rightBarButtonItem.action = #selector(editButtonPressed(_:))
        }
    }
    
    @objc private func cancelButtonTapped(sender: UIBarButtonItem) {
        for view in oneTimeDealsStackView.arrangedSubviews {
            if let oneTimeDealView = view as? OneTimeDealView {
                UIView.animate(withDuration: 0.3, animations: {
                    oneTimeDealView.dealActiveSwitch.isHidden = true
                })
            }
        }
        updateBarButtonsForMode(editModeOn: false)
    }
    
   @objc private func saveButtonTapped(sender: UIBarButtonItem) {
        for view in oneTimeDealsStackView.arrangedSubviews {
            if let oneTimeDealView = view as? OneTimeDealView {
                oneTimeDealView.saveDealStatus()
            }
        }
    }
    
    @objc private func doneButtonTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        updateBarButtonsForMode(editModeOn: false)
    }
   
    @IBAction func editButtonPressed(_ sender: Any) {
        updateBarButtonsForMode(editModeOn: true)
        for view in oneTimeDealsStackView.arrangedSubviews {
            if let oneTimeDealView = view as? OneTimeDealView {
                UIView.animate(withDuration: 0.3, animations: { 
                    oneTimeDealView.dealActiveSwitch.isHidden = false
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        merchantMapView.delegate = self
        updateBarButtonsForMode(editModeOn: false)
    }
    
    var currentMerchant: Merchant?
    
    func configureView() {
        if let merchant = currentMerchant {
            merchantName.text = merchant.name
            merchantAddress.text = merchant.address
            merchantContinualDeal.text = merchant.continualDeal

            if let oneTimeDeals = merchant.oneTimeDeals as? Set<OneTimeDeal> {
                for deal in oneTimeDeals {
                    let view = OneTimeDealView.createOneTimeDealView(deal: deal)
                    view.translatesAutoresizingMaskIntoConstraints = false
                    oneTimeDealsStackView.addArrangedSubview(view)
                }
                
            }
            
            if let address = merchantAddress.text {
                setupMKView(address: address, MKView: merchantMapView)
            }
        }
    }

    //MARK: Map View
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
}
