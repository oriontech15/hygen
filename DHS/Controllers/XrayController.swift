//
//  XrayController.swift
//  DHS
//
//  Created by Justin Smith on 9/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class XrayController {
    static let shared = XrayController()
    
    func createXray(patient: Patient,
                    pano: Bool,
                    bwx: Bool,
                    pa: Bool,
                    cbct: Bool,
                    schick: Bool,
                    scanx: Bool,
                    paNumber: Int?,
                    sets: Int?) -> Xray? {
        let xray = Xray(patient: patient, pano: pano, bwx: bwx, pa: pa, cbct: cbct, schick: schick, scanx: scanx, paNumber: paNumber, sets: sets)
        Stack.sharedStack.save()
        return xray
    }
    
    func updateXray(xray: Xray,
                    pano: Bool,
                    bwx: Bool,
                    pa: Bool,
                    cbct: Bool,
                    schick: Bool,
                    scanx: Bool,
                    paNumber: Int?,
                    sets: Int?) {
        xray.pano = pano
        xray.bwx = bwx
        xray.pa = pa
        xray.cbct = cbct
        xray.schick = schick
        xray.scanx = scanx
        xray.paNumber = Int32(paNumber ?? 0)
        xray.sets = Int32(sets ?? 0)
        Stack.sharedStack.save()
    }
    
    func deleteXray(xray: Xray) {
        xray.managedObjectContext?.delete(xray)
        Stack.sharedStack.save()
    }
}
