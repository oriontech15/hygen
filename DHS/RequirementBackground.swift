//
//  RequirementBackground.swift
//
//  Created on 6/9/17.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

import UIKit



class RequirementBackground: NSObject {
    
    
    //MARK: - Canvas Drawings
    
    /// Page 1
    
    class func drawRequirementBackground(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 314, height: 374), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        let baseTransform = context.userSpaceToDeviceSpaceTransform.inverted()
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 314, height: 374), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 314, y: resizedFrame.height / 374)
        context.translateBy(x: -377, y: -987)
        
        /// RequirementBackground
        do {
            context.saveGState()
            context.translateBy(x: 383, y: 989)
            
            /// Rectangle
            let rectangle = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 300, height: 360), cornerRadius: 30)
            context.saveGState()
            context.saveGState()
            context.beginPath()
            context.addPath(rectangle.cgPath)
            context.addRect(rectangle.bounds.insetBy(dx: -8, dy: -12))
            context.clip(using: .evenOdd)
            context.translateBy(x: -309, y: 0)
            do {
                let baseZero = context.convertToDeviceSpace(CGPoint.zero).applying(baseTransform)
                let baseOne = context.convertToDeviceSpace(CGPoint(x: 1, y: 1)).applying(baseTransform)
                let baseOffset = context.convertToDeviceSpace(CGPoint(x: 310, y: 5)).applying(baseTransform)
                let shadowOffset = CGSize(width: baseOffset.x - baseZero.x, height: baseOffset.y - baseZero.y)
                let shadowBlur: CGFloat = 7 * min(baseOne.x - baseZero.x, baseOne.y - baseZero.y)
                context.setShadow(offset: shadowOffset, blur: shadowBlur, color: UIColor(white: 0, alpha: 0.5).cgColor)
            }
            UIColor.black.setFill()
            rectangle.fill()
            context.restoreGState()
            context.saveGState()
            rectangle.addClip()
            context.drawLinearGradient(CGGradient(colorsSpace: nil, colors: [
                        UIColor(hue: 0.763, saturation: 0.653, brightness: 0.396, alpha: 1).cgColor,
                        UIColor(hue: 0.728, saturation: 0.563, brightness: 0.773, alpha: 1).cgColor,
                    ] as CFArray, locations: [0, 1])!,
                start: CGPoint(x: 150, y: 360),
                end: CGPoint(x: 150, y: 0),
                options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            context.restoreGState()
            context.restoreGState()
            
            /// Rectangle 9
            let rectangle9 = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 128, height: 158), cornerRadius: 20)
            context.saveGState()
            context.translateBy(x: 84, y: 110)
            UIColor(white: 1, alpha: 0.05).setFill()
            rectangle9.fill()
            context.restoreGState()
            
            /// Group 3
            do {
                context.saveGState()
                context.translateBy(x: 185, y: 248)
                
                /// Rectangle 3
                let rectangle3 = UIBezierPath()
                rectangle3.move(to: CGPoint(x: 3.93, y: 0.02))
                rectangle3.addLine(to: CGPoint(x: 5.12, y: 0))
                rectangle3.addLine(to: CGPoint(x: 5.12, y: 0))
                rectangle3.addCurve(to: CGPoint(x: 9.19, y: 3.93), controlPoint1: CGPoint(x: 7.33, y: -0.04), controlPoint2: CGPoint(x: 9.15, y: 1.72))
                rectangle3.addCurve(to: CGPoint(x: 9.19, y: 4.08), controlPoint1: CGPoint(x: 9.19, y: 3.98), controlPoint2: CGPoint(x: 9.19, y: 4.03))
                rectangle3.addLine(to: CGPoint(x: 8.88, y: 18.96))
                rectangle3.addLine(to: CGPoint(x: 8.88, y: 18.96))
                rectangle3.addCurve(to: CGPoint(x: 6.9, y: 20.92), controlPoint1: CGPoint(x: 8.85, y: 20.04), controlPoint2: CGPoint(x: 7.98, y: 20.91))
                rectangle3.addLine(to: CGPoint(x: 2.26, y: 20.98))
                rectangle3.addLine(to: CGPoint(x: 2.26, y: 20.98))
                rectangle3.addCurve(to: CGPoint(x: 0.24, y: 19.01), controlPoint1: CGPoint(x: 1.16, y: 21), controlPoint2: CGPoint(x: 0.26, y: 20.12))
                rectangle3.addLine(to: CGPoint(x: 0, y: 4.08))
                rectangle3.addLine(to: CGPoint(x: 0, y: 4.08))
                rectangle3.addCurve(to: CGPoint(x: 3.93, y: 0.02), controlPoint1: CGPoint(x: -0.03, y: 1.88), controlPoint2: CGPoint(x: 1.72, y: 0.06))
                rectangle3.close()
                rectangle3.move(to: CGPoint(x: 3.93, y: 0.02))
                context.saveGState()
                context.translateBy(x: 13.97, y: 11.23)
                context.rotate(by: 405 * CGFloat.pi/180)
                context.translateBy(x: -4.6, y: -10.49)
                rectangle3.usesEvenOddFillRule = true
                UIColor.white.setFill()
                rectangle3.fill()
                context.restoreGState()
                
                
                context.restoreGState()
            }
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    
    //MARK: - Canvas Images
    
    /// Page 1
    
    class func imageOfRequirementBackground() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 314, height: 374), false, 0)
        RequirementBackground.drawRequirementBackground()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    
    //MARK: - Resizing Behavior
    
    enum ResizingBehavior {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    
    
}
