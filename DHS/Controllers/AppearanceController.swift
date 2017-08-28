//
//  AppearanceController.swift
//  DHS
//
//  Created by Justin Smith on 6/13/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static let shared = AppearanceController()
    
    var mainColor: UIColor = .white {
        didSet {
            print(mainColor)
        }
    }
    
    var mainColorName: MainColorName = .white {
        didSet {
            print(mainColorName.rawValue)
            switch mainColorName {
            case .red:
                mainGradientColors = UIColor.redGradientColors()
                semiAlphaGradientColors = UIColor.redGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.redGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreateRed")
                progressButtonImage = #imageLiteral(resourceName: "ProgressRed")
                mainColor = UIColor.myRed()
                break
            case .orange:
                mainGradientColors = UIColor.orangeGradientColors()
                semiAlphaGradientColors = UIColor.orangeGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.orangeGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreateOrange")
                progressButtonImage = #imageLiteral(resourceName: "ProgressOrange")
                mainColor = UIColor.myOrange()
                break
            case .yellow:
                mainGradientColors = UIColor.yellowGradientColors()
                semiAlphaGradientColors = UIColor.yellowGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.yellowGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreateYellow")
                progressButtonImage = #imageLiteral(resourceName: "ProgressYellow")
                mainColor = UIColor.myYellow()
                break
            case .green:
                mainGradientColors = UIColor.greenGradientColors()
                semiAlphaGradientColors = UIColor.greenGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.greenGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreateGreen")
                progressButtonImage = #imageLiteral(resourceName: "ProgressGreen")
                mainColor = UIColor.myGreen()
                break
            case .blue:
                mainGradientColors = UIColor.blueGradientColors()
                semiAlphaGradientColors = UIColor.blueGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.blueGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreateBlue")
                progressButtonImage = #imageLiteral(resourceName: "ProgressBlue")
                mainColor = UIColor.myBlue()
                break
            case .purple:
                mainGradientColors = UIColor.purpleGradientColors()
                semiAlphaGradientColors = UIColor.purpleGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.purpleGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreatePurple")
                progressButtonImage = #imageLiteral(resourceName: "ProgressPurple")
                mainColor = UIColor.myPurple()
                break
            case .pink:
                mainGradientColors = UIColor.pinkGradientColors()
                semiAlphaGradientColors = UIColor.pinkGradientColorsSemiAlpha()
                almostAlphaGradientColors = UIColor.pinkGradientColorsAlmostAlpha()
                createButtonImage = #imageLiteral(resourceName: "CreatePink")
                progressButtonImage = #imageLiteral(resourceName: "ProgressPink")
                mainColor = UIColor.myPink()
            default:
                break
            }
        }
    }
    var createButtonImage: UIImage!
    var progressButtonImage: UIImage!
    var mainGradientColors: [UIColor] = []
    var semiAlphaGradientColors: [CGColor] = []
    var almostAlphaGradientColors: [CGColor] = []
}
