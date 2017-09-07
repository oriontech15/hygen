//
//  Extensions.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func redGradientColors() -> [UIColor] {
        return [UIColor(red: 0.949, green: 0.361, blue: 0.420, alpha: 1.00), UIColor(red: 0.792, green: 0.180, blue: 0.267, alpha: 1.00), UIColor(red: 0.663, green: 0.043, blue: 0.141, alpha: 1.00)]
    }
    
    static func orangeGradientColors() -> [UIColor] {
        return [UIColor(red: 0.965, green: 0.725, blue: 0.224, alpha: 1.00), UIColor(red: 0.976, green: 0.592, blue: 0.184, alpha: 1.00), UIColor(red: 0.992, green: 0.482, blue: 0.153, alpha: 1.00)]
    }
    
    static func yellowGradientColors() -> [UIColor] {
        return [UIColor(red: 0.996, green: 0.961, blue: 0.353, alpha: 1.00), UIColor(red: 0.996, green: 0.839, blue: 0.231, alpha: 1.00), UIColor(red: 0.992, green: 0.725, blue: 0.169, alpha: 1.00)]
    }
    
    static func greenGradientColors() -> [UIColor] {
        return [UIColor(red: 0.141, green: 0.875, blue: 0.459, alpha: 1.00), UIColor(red: 0.118, green: 0.769, blue: 0.380, alpha: 1.00), UIColor(red: 0.090, green: 0.663, blue: 0.302, alpha: 1.00)]
    }
    
    static func blueGradientColors() -> [UIColor] {
        return [UIColor(red: 0.165, green: 0.749, blue: 0.851, alpha: 1.00), UIColor(red: 0.149, green: 0.576, blue: 0.749, alpha: 1.00), UIColor(red: 0.141, green: 0.392, blue: 0.643, alpha: 1.00)]
    }
    
    static func purpleGradientColors() -> [UIColor] {
        return [UIColor(red: 0.537, green: 0.388, blue: 0.784, alpha: 1.00), UIColor(red: 0.431, green: 0.278, blue: 0.612, alpha: 1.00), UIColor(red: 0.322, green: 0.161, blue: 0.439, alpha: 1.00)]
    }
    
    static func pinkGradientColors() -> [UIColor] {
        return [UIColor(red: 0.655, green: 0.000, blue: 0.471, alpha: 1.00), UIColor(red: 0.988, green: 0.200, blue: 0.769, alpha: 1.00), UIColor(red: 1.000, green: 0.687, blue: 0.917, alpha: 1.00)]
    }
    
    static func redGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.949, green: 0.361, blue: 0.420, alpha: 0.0).cgColor, UIColor(red: 0.792, green: 0.180, blue: 0.267, alpha: 0.6).cgColor, UIColor(red: 0.663, green: 0.043, blue: 0.141, alpha: 1.00).cgColor]
    }
    
    static func orangeGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.965, green: 0.725, blue: 0.224, alpha: 0.0).cgColor, UIColor(red: 0.976, green: 0.592, blue: 0.184, alpha: 0.6).cgColor, UIColor(red: 0.992, green: 0.482, blue: 0.153, alpha: 1.00).cgColor]
    }
    
    static func yellowGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.996, green: 0.961, blue: 0.353, alpha: 0.0).cgColor, UIColor(red: 0.996, green: 0.839, blue: 0.231, alpha: 0.6).cgColor, UIColor(red: 0.992, green: 0.725, blue: 0.169, alpha: 1.00).cgColor]
    }
    
    static func greenGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.141, green: 0.875, blue: 0.459, alpha: 0.0).cgColor, UIColor(red: 0.118, green: 0.769, blue: 0.380, alpha: 0.6).cgColor, UIColor(red: 0.090, green: 0.663, blue: 0.302, alpha: 1.00).cgColor]
    }
    
    static func blueGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.165, green: 0.749, blue: 0.851, alpha: 0.0).cgColor, UIColor(red: 0.149, green: 0.576, blue: 0.749, alpha: 0.6).cgColor, UIColor(red: 0.141, green: 0.392, blue: 0.643, alpha: 1.00).cgColor]
    }
    
    static func purpleGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.537, green: 0.388, blue: 0.784, alpha: 0.0).cgColor, UIColor(red: 0.431, green: 0.278, blue: 0.612, alpha: 0.6).cgColor, UIColor(red: 0.322, green: 0.161, blue: 0.439, alpha: 1.00).cgColor]
    }
    
    static func pinkGradientColorsSemiAlpha() -> [CGColor] {
        return [UIColor(red: 0.655, green: 0.000, blue: 0.471, alpha: 0.0).cgColor, UIColor(red: 0.988, green: 0.200, blue: 0.769, alpha: 0.6).cgColor, UIColor(red: 1.000, green: 0.687, blue: 0.917, alpha: 1.0).cgColor]
    }
    
    static func redGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.949, green: 0.361, blue: 0.420, alpha: 0.0).cgColor, UIColor(red: 0.792, green: 0.180, blue: 0.267, alpha: 0.3).cgColor, UIColor(red: 0.663, green: 0.043, blue: 0.141, alpha: 0.8).cgColor]
    }
    
    static func orangeGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.965, green: 0.725, blue: 0.224, alpha: 0.0).cgColor, UIColor(red: 0.976, green: 0.592, blue: 0.184, alpha: 0.3).cgColor, UIColor(red: 0.992, green: 0.482, blue: 0.153, alpha: 0.8).cgColor]
    }
    
    static func yellowGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.996, green: 0.961, blue: 0.353, alpha: 0.0).cgColor, UIColor(red: 0.996, green: 0.839, blue: 0.231, alpha: 0.3).cgColor, UIColor(red: 0.992, green: 0.725, blue: 0.169, alpha: 0.8).cgColor]
    }
    
    static func greenGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.141, green: 0.875, blue: 0.459, alpha: 0.0).cgColor, UIColor(red: 0.118, green: 0.769, blue: 0.380, alpha: 0.3).cgColor, UIColor(red: 0.090, green: 0.663, blue: 0.302, alpha: 0.8).cgColor]
    }
    
    static func blueGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.165, green: 0.749, blue: 0.851, alpha: 0.0).cgColor, UIColor(red: 0.149, green: 0.576, blue: 0.749, alpha: 0.3).cgColor, UIColor(red: 0.141, green: 0.392, blue: 0.643, alpha: 0.8).cgColor]
    }
    
    static func purpleGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.537, green: 0.388, blue: 0.784, alpha: 0.0).cgColor, UIColor(red: 0.431, green: 0.278, blue: 0.612, alpha: 0.3).cgColor, UIColor(red: 0.322, green: 0.161, blue: 0.439, alpha: 0.8).cgColor]
    }
    
    static func pinkGradientColorsAlmostAlpha() -> [CGColor] {
        return [UIColor(red: 0.655, green: 0.000, blue: 0.471, alpha: 0.0).cgColor, UIColor(red: 0.988, green: 0.200, blue: 0.769, alpha: 0.3).cgColor, UIColor(red: 1.000, green: 0.687, blue: 0.917, alpha: 0.8).cgColor]
    }
    
    static func lightPurple() -> UIColor {
        return UIColor(red: 0.835, green: 0.745, blue: 0.988, alpha: 1.00)
    }
    
    static func lightRed() -> UIColor {
        return UIColor(red: 1.000, green: 0.812, blue: 0.827, alpha: 1.00)
    }
    
    static func lightOrange() -> UIColor {
        return UIColor(red: 1.000, green: 0.804, blue: 0.678, alpha: 1.00)
    }
    
    static func lightGreen() -> UIColor {
        return UIColor(red: 0.647, green: 0.996, blue: 0.804, alpha: 1.00)
    }
    
    static func lightBlue() -> UIColor {
        return UIColor(red: 0.655, green: 0.941, blue: 0.996, alpha: 1.00)
    }
    
    static func lightYellow() -> UIColor {
        return UIColor(red: 1.000, green: 0.988, blue: 0.729, alpha: 1.00)
    }
    
    static func myRed() -> UIColor {
        return UIColor(red: 0.992, green: 0.224, blue: 0.333, alpha: 1.00)
    }
    
    static func myOrange() -> UIColor {
        return UIColor(red: 0.980, green: 0.584, blue: 0.102, alpha: 1.00)
    }
    
    static func myYellow() -> UIColor {
        return UIColor(red: 1.000, green: 0.878, blue: 0.173, alpha: 1.00)
    }
    
    static func myGreen() -> UIColor {
        return UIColor(red: 0.012, green: 0.773, blue: 0.337, alpha: 1.00)
    }
    
    static func myBlue() -> UIColor {
        return UIColor(red: 0.098, green: 0.580, blue: 0.757, alpha: 1.00)
    }
    
    static func myPurple() -> UIColor {
        return UIColor(red: 0.557, green: 0.341, blue: 0.824, alpha: 1.00)
    }
    
    static func myGray() -> UIColor {
        return UIColor(red: 0.423, green: 0.423, blue: 0.423, alpha: 1.00)
    }
    
    static func myLightGray() -> UIColor {
        return UIColor(red: 0.940, green: 0.940, blue: 0.940, alpha: 1.00)
    }
    
    static func myPink() -> UIColor {
        return UIColor(red: 0.988, green: 0.200, blue: 0.769, alpha: 1.00)
    }
}

extension NSDate {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        let dateStr = dateFormatter.string(from: self as Date)
        return dateStr
    }
    
    func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        //        let calendar = Calendar.current
        //        let comp = calendar.dateComponents([.hour, .minute], from: self as Date)
        //        let hour = comp.hour
        //        let minute = comp.minute
        //        return "\(hour)"
        return dateFormatter.string(from: self as Date)
    }
    
    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.day], from: self as Date)
        return "\(comp)"
    }
    
    public static func <(a: NSDate, b: NSDate) -> Bool {
        return a.compare(b as Date) == ComparisonResult.orderedAscending
    }
}

extension NSSet {
    var toXrays: [Xray] {
        return self.allObjects as? [Xray] ?? []
    }
}
