//
//  YelpDataParser.swift
//  Axxess+
//
//  Created by Michelline Tran on 8/13/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import Foundation

struct YelpInfo {
    let businessURL: String
    let businessRating: Double
    let businessReviewCount: Int
}

func parse(yelpData: [String: Any]) -> YelpInfo {
    let merchant = (yelpData["businesses"] as! [[String: Any]]).first!
    let merchantYelpURL = merchant["url"] as! String
    let merchantYelpRating = merchant["rating"] as! Double
    let merchantYelpReviewCount = merchant["review_count"] as! Int

    return YelpInfo(businessURL: merchantYelpURL, businessRating: merchantYelpRating, businessReviewCount: merchantYelpReviewCount)
}
