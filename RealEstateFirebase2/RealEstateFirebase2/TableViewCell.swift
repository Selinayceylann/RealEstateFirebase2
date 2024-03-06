//
//  TableViewCell.swift
//  RealEstateFirebase2
//
//  Created by selinay ceylan on 5.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var pricText: UILabel!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var houseTypeText: UILabel!
    @IBOutlet weak var numberofRoomsText: UILabel!
    @IBOutlet weak var telephoneNumberText: UILabel!
    @IBOutlet weak var imageVie: UIImageView!
    @IBOutlet weak var emailText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    
}
