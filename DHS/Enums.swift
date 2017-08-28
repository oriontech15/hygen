//
//  Enums.swift
//  DHS
//
//  Created by Justin Smith on 6/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

enum RequirementType: String {
    case class1A = "Class 1A"
    case class1B = "Class 1B"
    case class2 = "Class 2"
    case class3 = "Class 3"
    case class4 = "Class 4"
    case class5 = "Class 5"
    case pano = "Pano"
    case bwx = "BWX"
    case pa = "PA"
    case injection = "Injections"
    case defaultClass = "Default"
}

enum MainColorName: String {
    case red, orange, yellow, green, blue, purple, pink, white
}

enum CellLocation {
    case off, first, last, neither
}

enum xRayRequirement: Int {
    case pano, bwx, pa
}

enum xRayType: Int {
    case cbct, schick, scanX
}
