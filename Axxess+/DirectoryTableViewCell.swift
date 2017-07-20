//
//  DirectoryTableViewCell.swift
//  Axxess+
//
//  Created by Michelline Tran on 7/19/17.
//  Copyright © 2017 Michelline Tran. All rights reserved.
//

import UIKit
import CoreData

class DirectoryTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var useOneTimeDeal: UIButton!
    @IBOutlet weak var viewDetails: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
