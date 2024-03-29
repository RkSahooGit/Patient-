//
//  PatientDetailsViewController.swift
//  PatientRecordProject
//
//  Created by Rakesh Kumar Sahoo on 21/02/24.
//

import UIKit

class PatientDetailsViewController: UIViewController {
    
    private var users:[PatientEntity] = []
    private let manager = PatientDataBase()
    
    @IBOutlet weak var patientDetailsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientDetailsTable.register(UINib(nibName: "PatientTableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = manager.fetchUser()
        patientDetailsTable.reloadData()
    }
    
    @IBAction func addPatientDetails(_ sender: UIBarButtonItem) {
        addUpdateUserNavigation()
        
    }
    
    func addUpdateUserNavigation(user:PatientEntity? = nil){
        guard let addButtonPressed = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else{return}
        addButtonPressed.user = user
        navigationController?.pushViewController(addButtonPressed, animated: true)
    }
    
}

extension PatientDetailsViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PatientTableViewCell
        cell.patientnameXiblable.text = users[indexPath.row].patientName
        cell.patientAgeXibLable.text = users[indexPath.row].patientAge
        cell.patientGenderXibLable.text = users[indexPath.row].patientGender
        
        let imageURL = URL.documentsDirectory.appending(components: users[indexPath.row].patientImagee ?? "").appendingPathExtension("png")
        cell.patientImageXib.image = UIImage(contentsOfFile: imageURL.path)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "patientDetails") as? PatientProfileViewController
        let imageURL = URL.documentsDirectory.appending(components: users[indexPath.row].patientImagee ?? "").appendingPathExtension("png")
        vc?.imageOfSelectedCell = UIImage(contentsOfFile: imageURL.path) ?? UIImage(systemName: "photo.fill")!
        vc?.name = users[indexPath.row].patientName ?? "no value"
        vc?.age = users[indexPath.row].patientAge ?? "no value"
        vc?.gender = users[indexPath.row].patientGender ?? "no value"
        vc?.phoneNo = users[indexPath.row].patientPhone ?? "no value"
        vc?.email = users[indexPath.row].patientMail ?? "no value"
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "UPDATE"){_,_,_ in
            self.addUpdateUserNavigation(user: self.users[indexPath.row])
        }
        update.backgroundColor = .systemIndigo
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){ _, _, _ in
            
            self.manager.deleteUser(userEntity: self.users[indexPath.row])
            self.users.remove(at: indexPath.row)
            self.patientDetailsTable.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete , update ])
    }
    
    
    
}
