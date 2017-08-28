//
//  ClassTagView.swift
//  DHS
//
//  Created by Justin Smith on 7/20/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ClassTagView: UIView {
    
    var requirementType: RequirementType = .defaultClass {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var complete: Bool = false
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        if complete {
            switch self.requirementType {
            case .class1A:
                StyleKit.drawCompleteClass1ATag(frame: self.bounds)
                break
            case .class1B:
                StyleKit.drawCompleteClass1BTag(frame: self.bounds)
                break
            case .class2:
                StyleKit.drawCompleteClass2Tag(frame: self.bounds)
                break
            case .class3:
                StyleKit.drawCompleteClass3Tag(frame: self.bounds)
                break
            case .class4:
                StyleKit.drawCompleteClass4Tag(frame: self.bounds)
                break
            case .class5:
                StyleKit.drawCompleteClass5Tag(frame: self.bounds)
                break
            case .defaultClass:
                break
            default:
                break
            }
        } else {
            switch self.requirementType {
            case .class1A:
                StyleKit.drawClass1ATag(frame: self.bounds)
                break
            case .class1B:
                StyleKit.drawClass1BTag(frame: self.bounds)
                break
            case .class2:
                StyleKit.drawClass2Tag(frame: self.bounds)
                break
            case .class3:
                StyleKit.drawClass3Tag(frame: self.bounds)
                break
            case .class4:
                StyleKit.drawClass4Tag(frame: self.bounds)
                break
            case .class5:
                StyleKit.drawClass5Tag(frame: self.bounds)
                break
            case .defaultClass:
                break
            default:
                break
            }
        }
    }
}
