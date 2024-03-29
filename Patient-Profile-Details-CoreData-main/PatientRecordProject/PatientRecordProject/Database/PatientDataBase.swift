//
//  PatientDataBase.swift
//  PatientRecordProject
//
//  Created by Rakesh Kumar Sahoo on 21/02/24.
//

import UIKit
import CoreData

class PatientDataBase{
    
    private var context:NSManagedObjectContext{
        (UIApplication.shared.delegate as!
         AppDelegate).persistentContainer.viewContext
    }
    
   func addUser(_ user: UserModel){
        
        let patientEntity = PatientEntity(context: context)// creating new user
        patientEntity.patientName = user.name
        patientEntity.patientMail = user.email
        patientEntity.patientPhone = user.phoneNumber
        patientEntity.patientGender = user.gender
        patientEntity.patientAge = user.age
       patientEntity.patientImagee = user.image
        
        do{
            try context.save()
        }catch{
            print("User saving error:-", error)
        }
   }
    func upadateUser(user: UserModel, patientEntity: PatientEntity){
        patientEntity.patientName = user.name
        patientEntity.patientMail = user.email
        patientEntity.patientPhone = user.phoneNumber
        patientEntity.patientGender = user.gender
        patientEntity.patientAge = user.age
       patientEntity.patientImagee = user.image
        
        do{
            try context.save()
        }catch{
            print("User saving error:-", error)
        }
    }
    
    func fetchUser()->[PatientEntity]{
        
        var users:[PatientEntity]=[]
        do{
            users = try context.fetch(PatientEntity.fetchRequest())
        }catch{
            print("Fetch user error:",error)
        }
        return users
    }
    func deleteUser(userEntity: PatientEntity){
        let imageURL = URL.documentsDirectory.appending(component: userEntity.patientImagee ?? "").appendingPathExtension("png")
        do{
            try FileManager.default.removeItem(at: imageURL)
        }catch{
            print("remove image from document directory")
        }
        
        context.delete(userEntity)
        do{
            try context.save()
        }catch{
            print("User saving error:-", error)
        }
    }
}
