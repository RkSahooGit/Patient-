//
//  PatientTableViewCell.swift
//  PatientRecordProject
//
//  Created by Rakesh Kumar Sahoo on 21/02/24.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var patientnameXiblable: UILabel!
    @IBOutlet weak var patientAgeXibLable: UILabel!
    @IBOutlet weak var patientGenderXibLable: UILabel!
    @IBOutlet weak var patientImageXib: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        patientImageXib.layer.cornerRadius = patientImageXib.frame.size.height / 2
    }

    
    
}
