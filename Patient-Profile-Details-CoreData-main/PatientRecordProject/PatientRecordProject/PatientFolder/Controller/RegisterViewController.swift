//
//  ViewController.swift
//  PatientRecordProject
//
//  Created by Rakesh Kumar Sahoo on 21/02/24.
//

import UIKit
import PhotosUI

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientMail: UITextField!
    @IBOutlet weak var patientPhone: UITextField!
    @IBOutlet weak var patientGender: UITextField!
    @IBOutlet weak var patientAge: UITextField!
    @IBOutlet weak var registerButton : UIButton!
    
    private let manager = PatientDataBase()
    private var imageSelectedByUser: Bool = false
    
    var user : PatientEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension RegisterViewController{
    
    func configuration(){
        uiConfiguration()
        imageTappedGesture()
        userDetailsForUpdate()
    }
    func uiConfiguration(){
        patientImage.layer.cornerRadius = patientImage.frame.size.height / 2
    }
    
    func imageTappedGesture(){
        let imageTap = UITapGestureRecognizer(target: self, 
                                              action: #selector(RegisterViewController.openGallery))
        patientImage.addGestureRecognizer(imageTap)
    }
    //User Details Passed By Pressing Update Button
    func userDetailsForUpdate(){
        if let user {
            registerButton.setTitle("Update", for: .normal)
            navigationItem.title = "Update Patient Details"
        
            patientName.text = user.patientName
            patientMail.text = user.patientMail
            patientAge.text = user.patientAge
            patientGender.text = user.patientGender
            patientPhone.text = user.patientPhone
            
            let imageURL = URL.documentsDirectory.appending(components: user .patientImagee ?? "").appendingPathExtension("png")
            patientImage.image = UIImage(contentsOfFile: imageURL.path)
            
            imageSelectedByUser = true
        }else{
            registerButton.setTitle("Register", for: .normal)

            navigationItem.title = "Add Patient Details"

        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        guard let name = patientName.text, !name.isEmpty else {
            openAlert(message: "Please enter your name")
            return
        }
        guard let email = patientMail.text, !email.isEmpty else {
            openAlert(message: "Please enter your email address")
            return
        }
        
        guard let phoneNumber = patientPhone.text, !phoneNumber.isEmpty else {
            openAlert(message: "Please enter your phone number")
            return
        }
        guard let gender = patientGender.text, !gender.isEmpty else {
            openAlert(message: "Please enter your gender")
            return
        }
        guard let age = patientAge.text, !age.isEmpty else {
            openAlert(message: "Please enter your age")
            return
        }
        if !imageSelectedByUser{
            openAlert(message: "Please choose your profile image")
            return
        }
        
       
        
        if let user {
            
            var newUser = UserModel(
                name: name,
                email: email,
                phoneNumber: phoneNumber,
                gender: gender,
                age: age,
                image: user.patientImagee ?? ""
            )
            
            manager.upadateUser(user: newUser, patientEntity: user)
            saveImageToDocumentDirectory(imageName: newUser.image)

        }else{
            let image = UUID().uuidString
            let newUser = UserModel(
                name: name,
                email: email,
                phoneNumber: phoneNumber,
                gender: gender,
                age: age,
                image: image
            )
            
            saveImageToDocumentDirectory(imageName: image)
            manager.addUser(newUser)
        }
        
        navigationController?.popViewController(animated: true)
    }
    func saveImageToDocumentDirectory(imageName: String){
        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        if let data = patientImage.image?.pngData() {
            do {
                try data.write(to: fileURL) // Save
            }catch {
                print("Saving image to Document Directory error:", error)
            }
        }
    }
    
    @objc func openGallery(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        
        let imagePickerVC = PHPickerViewController(configuration: config)
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
}
extension RegisterViewController {
    
    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", 
                                                message: message,
                                                preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", 
                                 style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
}
extension RegisterViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       dismiss(animated: true)
        for result in results{
            result.itemProvider.loadObject(ofClass: UIImage.self){image, error in
                guard let image = image as? UIImage else {return}
                DispatchQueue.main.async {
                    self.patientImage.image = image
                    self.imageSelectedByUser = true
                   
                }
               
                
            }
                
            }
        }
    }
    
    


