//
//  StudentdataTableViewCell.swift
//  Coredata1
//
//  Created by Mac on 02/01/25.
//

import UIKit

class StudentdataTableViewCell: UITableViewCell {

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailIdTF: UITextField!
    @IBOutlet var userIdTF: UITextField!
    @IBOutlet var phoneNOTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    
    @IBOutlet var pincodeTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
