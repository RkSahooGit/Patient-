//
//  PatientProfileViewController.swift
//  PatientRecordProject
//
//  Created by Rakesh Kumar Sahoo on 21/02/24.
//

import UIKit

class PatientProfileViewController: UIViewController {
    
    private var users:[PatientEntity] = []
    
    @IBOutlet weak var nameOfPatient: UILabel!
    @IBOutlet weak var genderAndAgeOfPatient: UILabel!
    @IBOutlet weak var idOfPatient: UILabel!
    @IBOutlet weak var imageOfPatient: UIImageView!
    @IBOutlet weak var phoneNoOfPatient: UILabel!
    @IBOutlet weak var emailOfPatient: UILabel!
    @IBOutlet weak var affectedSideOfPatient: UILabel!
    @IBOutlet weak var conditionOfPatient: UILabel!
    @IBOutlet weak var specialityOfPatient: UILabel!
    
    
    var imageOfSelectedCell = UIImage()
    var name = ""
    var age = ""
    var gender = ""
    var id = "Patient Id:87 20200727153457"
    var phoneNo = ""
    var email = ""
    var affectedSide = "Bilateral"
    var condition = "Ortho"
    var speciality = "Osteoarthritis"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Patient Profile"
        imageOfPatient.layer.cornerRadius = imageOfPatient.frame.size.height / 2
        
       imageOfPatient.image = imageOfSelectedCell
       nameOfPatient.text = name
        genderAndAgeOfPatient.text = gender + "/" + age
        idOfPatient.text = id
        phoneNoOfPatient.text = "📞 "+phoneNo
        emailOfPatient.text = "✉️ "+email
        affectedSideOfPatient.text = "🩸" + "affectedSide"
        conditionOfPatient.text = "🦴"+condition
        specialityOfPatient.text = "🩻"+speciality
    }
}


