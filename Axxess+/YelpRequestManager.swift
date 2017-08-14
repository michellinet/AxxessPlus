//
//  YelpRequestManager.swift
//  Axxess+
//
//  Created by Michelline Tran on 8/13/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation
import Alamofire

class YelpRequestManager {
    static let clientID = "KqSSfJebmlAtH7EeKepzyg"
    static let clientSecret = "9heSplVTpvfi9sKfdNJSX2Yu7BB08Janiu0TNlvKw2Wu5ULljgcZktkyheLpdHNO"
    var accessToken: String!

    func getAuthToken(completion: @escaping (_ accessToken: String?) -> Void) {
        let urlString = "https://api.yelp.com/oauth2/token"
        let url = try! urlString.asURL()
        let parameters = ["grant_type" : "client_credentials",
                          "client_id": YelpRequestManager.clientID,
                          "client_secret": YelpRequestManager.clientSecret]

        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            guard response.result.isSuccess else {
                print("Error: Unable to request access token.")
                completion(nil)
                return
            }

            guard let value = response.result.value as? [String: Any] else {
                print("Error: Malformed data received.")
                completion(nil)
                return
            }

            if let token = value["access_token"] as? String {
                completion(token)
            } else {
                completion(nil)
            }
        }
    }

    func fetchMerchantYelpInfo(merchant: Merchant, completion: @escaping (_ merchantInfo: [String: Any]?) -> Void) {
        let token = UserDefaults.standard.object(forKey: "yelp_access_token") as! String
        let urlString = "https://api.yelp.com/v3/businesses/search"
        let url = try! urlString.asURL()

        if let businessName = merchant.name, let businessAddress = merchant.address {
            let parameters = ["term": businessName, "location": businessAddress, "limit": 1 as Any]

            Alamofire.request(url, method: .get, parameters: parameters, headers: ["Authorization": "Bearer \(token)"]).responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error: Unable to find business using merchant address.")
                    completion(nil)
                    return
                }

                guard let value = response.result.value as? [String: Any] else {
                    print ("Error: Malformed data received.")
                    completion(nil)
                    return
                }

                completion(value)
            }
        }
    }
}
