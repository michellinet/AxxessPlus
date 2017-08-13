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

    func getAuthToken() -> String {
        let urlString = "https://api.yelp.com/oauth2/token"
        let url = try! urlString.asURL()
        let parameters = ["grant_type" : "client_credentials",
                          "client_id": YelpRequestManager.clientID,
                          "client_secret": YelpRequestManager.clientSecret]

        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            guard response.result.isSuccess else {
                print("Error: Unable to request access token.")
                return
            }

            guard let value = response.result.value as? [String: Any] else {
                print("Error: Malformed data received.")
                return
            }
            self.accessToken = value["access_token"] as? String
        }

        return accessToken
    }

    func fetchMerchantYelpInfo(merchant: Merchant) -> [String: Any] {
        let urlString = "https://api.yelp.com/v3/businesses/search"
        let url = try! urlString.asURL()
        var businessInfo = [String: Any]()

        if let businessAddress = merchant.address {
            let parameters = ["location": businessAddress]

            Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error: Unable to find business using merchant address.")
                    return
                }

                guard let value = response.result.value as? [String: Any] else {
                    print ("Error: Malformed data received.")
                    return
                }
                businessInfo = value
            }

        }

        return businessInfo
    }
}
