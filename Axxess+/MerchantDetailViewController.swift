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
    @IBOutlet weak var merchantAddressTextView: UITextView!
    @IBOutlet weak var merchantContinualDeal: UILabel!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var oneTimeDealsStackView: UIStackView!
    @IBOutlet weak var oneTimeDealsHeader: UILabel!
    @IBOutlet weak var yelpInfoSpinner: UIActivityIndicatorView!

    //MARK: Yelp Info
    @IBAction func yelpInfoButtonPressed(_ sender: UIButton) {
        /// Reset spinner & button
        sender.isHidden = true
        yelpInfoSpinner.isHidden = false
        yelpInfoSpinner.startAnimating()

        /// Request Yelp Info
        let manager = YelpRequestManager()
        if let merchant = currentMerchant {
            manager.fetchMerchantYelpInfo(merchant: merchant) { (info) in

                /// Offline or failed to grab info
                guard let info = info else {
                    let alert = UIAlertController(title: "Uh oh!", message: "You're offline! \nPlease go online to view Yelp Info.", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Bummer!", style: .cancel, handler: nil)
                    dismiss.setValue(UIColor(colorLiteralRed: 77/255.0, green: 21/255.0, blue: 186/255.0, alpha: 1.0), forKey: "titleTextColor")
                    alert.addAction(dismiss)
                    self.present(alert, animated: true, completion: {
                        self.yelpInfoSpinner.isHidden = true
                        self.yelpInfoSpinner.stopAnimating()
                        sender.isHidden = false
                    })
                    return
                }

                /// Present info in alert & link to Yelp
                let merchantYelpInfo = parse(yelpData: info)

                let alert = UIAlertController(title: "Yelp Info", message: "\n\(merchantYelpInfo.businessRating) stars\n based on \(merchantYelpInfo.businessReviewCount) reviews", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Yay!", style: .cancel, handler: nil)
                dismiss.setValue(UIColor(colorLiteralRed: 77/255.0, green: 21/255.0, blue: 186/255.0, alpha: 1.0), forKey: "titleTextColor")
                let urlAction = UIAlertAction(title: "View on Yelp", style: .default, handler: { _ in
                    if let url = URL(string: merchantYelpInfo.businessURL) {
                        UIApplication.shared.open(url)
                    }
                })
                urlAction.setValue(UIColor(colorLiteralRed: 77/255.0, green: 21/255.0, blue: 186/255.0, alpha: 1.0), forKey: "titleTextColor")
                alert.addAction(dismiss)
                alert.addAction(urlAction)

                self.present(alert, animated: true, completion: {
                    self.yelpInfoSpinner.isHidden = true
                    self.yelpInfoSpinner.stopAnimating()
                    sender.isHidden = false
                })
            }
        }
    }

// MARK: UIBarButtonItems
    private func updateBarButtonsForMode(editModeOn: Bool) {
        if editModeOn == true {
            for view in oneTimeDealsStackView.arrangedSubviews {
                if let oneTimeDealView = view as? OneTimeDealView {
                    UIView.animate(withDuration: 0.3, animations: {
                        oneTimeDealView.dealActiveSwitch.isHidden = false
                    })
                }
            }

            leftBarButtonItem.title = "Cancel"
            leftBarButtonItem.style = .done
            leftBarButtonItem.action =  #selector(cancelButtonTapped(sender:))
            rightBarButtonItem.title = "Save"
            rightBarButtonItem.style = .plain
            rightBarButtonItem.action = #selector(saveButtonTapped(sender:))
        } else {
            for view in oneTimeDealsStackView.arrangedSubviews {
                if let oneTimeDealView = view as? OneTimeDealView {
                    UIView.animate(withDuration: 0.3, animations: {
                        oneTimeDealView.dealActiveSwitch.isHidden = true
                    })
                }
            }

            leftBarButtonItem.title = "Done"
            leftBarButtonItem.style = .done
            leftBarButtonItem.action = #selector(doneButtonTapped(sender:))
            rightBarButtonItem.title = "Edit"
            rightBarButtonItem.style = .plain
            rightBarButtonItem.action = #selector(editButtonPressed(_:))
        }
    }
    
    @objc private func cancelButtonTapped(sender: UIBarButtonItem) {
        updateBarButtonsForMode(editModeOn: false)
        for view in oneTimeDealsStackView.arrangedSubviews {
            if let oneTimeDealView = view as? OneTimeDealView {
                oneTimeDealView.updateView()
            }
        }
    }
    
    @objc private func saveButtonTapped(sender: UIBarButtonItem) {
        var alert = UIAlertController()
        for view in oneTimeDealsStackView.arrangedSubviews {
            if let oneTimeDealView = view as? OneTimeDealView {
                oneTimeDealView.saveDealStatus()
                if oneTimeDealView.dealActiveSwitch.isOn {
                    alert = UIAlertController(title: "Whoop!", message: "Your deal is re-activated!", preferredStyle: .alert)
                } else {
                    alert = UIAlertController(title: "Cash Out!", message: "You've used your one time deal!", preferredStyle: .alert)
                }
            }
        }

        let dismiss = UIAlertAction(title: "Sweet!", style: .default, handler: nil)
        dismiss.setValue(UIColor(colorLiteralRed: 77/255.0, green: 21/255.0, blue: 186/255.0, alpha: 1.0), forKey: "titleTextColor")
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
        updateBarButtonsForMode(editModeOn: false)
        
    }
    
    @objc private func doneButtonTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        updateBarButtonsForMode(editModeOn: false)
    }
   
    @IBAction func editButtonPressed(_ sender: Any) {
        updateBarButtonsForMode(editModeOn: true)
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
            merchantAddressTextView.text = merchant.address
            merchantContinualDeal.text = merchant.continualDeal

            if let oneTimeDeals = merchant.oneTimeDeals as? Set<OneTimeDeal> {
                if oneTimeDeals.count == 0 {
                    oneTimeDealsHeader.isHidden = true
                }
                for deal in oneTimeDeals {
                    let view = OneTimeDealView.createOneTimeDealView(deal: deal)
                    view.translatesAutoresizingMaskIntoConstraints = false
                    oneTimeDealsStackView.addArrangedSubview(view)
                }
            }

            if let address = merchant.address {
                setupMKView(address: address, MKView: merchantMapView)
            }
        }
    }

// MARK: Map View
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
