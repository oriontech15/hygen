//
//  PatientsController.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import CoreData

class PatientsController {
    
    static let shared = PatientsController()
    
    var sortedDates: [NSDate] = []
    
    var patients: [Patient] = []
    
    @objc func checkPatients() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Patient")
        let context = Stack.sharedStack.managedObjectContext
        
        var patients: [Patient] = []
        
        do {
            patients = try context.fetch(request) as! [Patient]
            print(patients.count)
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.patients = patients
    }
    
    init() {
        checkPatients()
        NotificationCenter.default.addObserver(self, selector: #selector(checkPatients), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    func completePatient(patient: Patient, isComplete: Bool) {
        patient.complete = isComplete
        Stack.sharedStack.save()
    }
    
    func createPatient(firstName: String, lastName: String, date: Date, requirement: Requirement, user: User = UserController.shared.currentUser!) -> Patient? {
        guard let patient = Patient(firstName: firstName, lastName: lastName, dateOfAppointment: date, classType: requirement, user: user) else { return nil }
        patient.requirement.addToPatients(patient)
        Stack.sharedStack.save()
        return patient
    }
    
    func removePatient(patient: Patient, confirm: Bool) {
        if confirm {
            print(patient.requirement.type)
            print(patient.firstName)
            print(patient.lastName)
            print(patient.dateOfAppointment.toString())
            Stack.sharedStack.managedObjectContext.delete(patient)
            Stack.sharedStack.save()
        }
    }
    
    func updatePatientClassRequirement(patient: Patient, requirement: Requirement) {
        print(patient.requirement.patients!.count)
        if var patients = patient.requirement.patients?.allObjects as? [Patient] {
            for patient in patients {
                print(patient.firstName + " " + patient.lastName)
            }
            if let index = patients.index(of: patient) {
                patients.remove(at: index)
                patient.requirement = requirement
                Stack.sharedStack.save()
            } else {
                print("COULD NOT FIND INDEX OF PATIENT IN REQUIREMENT: \(requirement.type)")
            }
        } else {
            print("COULD NOT CONVERT PATIENTS FROM REQUIREMENT: \(requirement.type)")
        }
    }
    
    func updatePatientXRays(patient: Patient, xray: Xray) {
        patient.addToXrays(xray)
        Stack.sharedStack.save()
    }
    
    func updateDateFor(patient: Patient, date: NSDate) {
        patient.dateOfAppointment = date
        Stack.sharedStack.save()
    }
    
    func updateQuadsFor(patient: Patient, quads: Int) {
        patient.quads = Int64(quads)
        Stack.sharedStack.save()
    }
    
    func updateInjectionsFor(patient: Patient, injectionsOn: Bool?, injections: Int) {
        patient.injectionsOn = injectionsOn ?? false
        patient.injections = Int32(injections)
        Stack.sharedStack.save()
    }
    
    func updateNotesFor(patient: Patient, notes: String) {
        patient.notes = notes
        Stack.sharedStack.save()
    }
    
    func updateEmailFor(patient: Patient, email: String) {
        patient.email = email
        Stack.sharedStack.save()
    }
    
    func updatePhoneFor(patient: Patient, phone: String) {
        patient.phone = phone
        Stack.sharedStack.save()
    }
    
    func patientsWithClassName(classType: RequirementType, completion: @escaping (_ patients: [Patient]) -> Void) {
        
        var patients: [Patient] = []
        
        for patient in self.patients {
            if patient.requirement.type == classType.rawValue {
                patients.append(patient)
            }
        }
        completion(patients)
    }
    
    func patientsWithXray(xrayType: xRayRequirement, completion: @escaping (_ patients: [Patient]) -> Void) {
        
        var patients: [Patient] = []
        for patient in self.patients {
            if let xrays = patient.xrays?.toXrays {
                for xray in xrays {
                    switch xrayType {
                    case .pano:
                        if xray.pano == true {
                            patients.append(patient)
                        }
                        break
                    case .bwx:
                        if xray.bwx == true {
                            patients.append(patient)
                        }
                        break
                    case .pa:
                        if xray.pa == true {
                            patients.append(patient)
                        }
                        break
                    }
                }
            }
        }
        completion(patients)
    }
    
    func patientsWithInjections(completion: @escaping (_ patients: [Patient]) -> Void) {
        var patients: [Patient] = []
        print(self.patients.count)
        for patient in self.patients {
            print(patient.injections)
            if patient.injectionsOn {
                if patient.injections > 0 {
                    patients.append(patient)
                }
            }
        }
        completion(patients)
    }
    
    func getPatientsWithDate(date: NSDate) -> [Patient] {
        var patients: [Patient] = []
        
        for patient in self.patients {
            if patient.dateOfAppointment.toString() == date.toString() {
                patients.append(patient)
            }
        }
        
        return patients
    }
    
    func getPatientsWithDate(patients: [Patient], date: NSDate) -> [Patient] {
        var newPatients: [Patient] = []
        
        for patient in patients {
            if patient.dateOfAppointment.toString() == date.toString() {
                newPatients.append(patient)
            }
        }
        
        return newPatients
    }
    
    func getDatesForPatients() -> [NSDate] {
        var dates: [NSDate] = []
        var dateString: [String] = []
        for patient in self.patients {
            var result: Bool = false
            if let index = dateString.index(of: patient.dateOfAppointment.toString()) {
                if dateString[index] == patient.dateOfAppointment.toString() {
                    result = false
                } else {
                    dateString.append(patient.dateOfAppointment.toString())
                    result = true
                }
            } else {
                dateString.append(patient.dateOfAppointment.toString())
                result = true
            }
            
            if result {
                dates.append(patient.dateOfAppointment)
            }
        }
        
        self.sortedDates = dates.sorted { $0 < $1 }
        print(self.sortedDates)
        return self.sortedDates
    }
    
    func getDatesForPatients(patients: [Patient]) -> [NSDate] {
        var dates: [NSDate] = []
        var dateString: [String] = []
        for patient in patients {
            var result: Bool = false
            if let index = dateString.index(of: patient.dateOfAppointment.toString()) {
                if dateString[index] == patient.dateOfAppointment.toString() {
                    result = false
                } else {
                    dateString.append(patient.dateOfAppointment.toString())
                    result = true
                }
            } else {
                dateString.append(patient.dateOfAppointment.toString())
                result = true
            }
            
            if result {
                dates.append(patient.dateOfAppointment)
            }
        }
        
        let sortedDates = dates.sorted { $0 < $1 }

        return sortedDates
    }
    
    func sortPatientsByDate(completion: (_ patientsDict: [String : [Patient]]) -> Void ) {
        
        var patientDict: [String : [Patient]] = [:]
        
        print(self.sortedDates.count)
        print(self.patients.count)
        
        for date in self.sortedDates {
            patientDict[date.toString()] = []
            for patient in patients {
                if date == patient.dateOfAppointment {
                    print(date)
                    print(patient.firstName)
                    print(patient.dateOfAppointment)
                    patientDict[date.toString()]?.append(patient)
                }
                print(patientDict[date.toString()]!.count)
            }
        }
        completion(patientDict)
    }
}
