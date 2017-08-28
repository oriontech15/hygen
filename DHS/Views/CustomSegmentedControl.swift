//
//  CustomSegmentedControl.swift
//  Apt. 50
//
//  Created by Justin Smith on 11/14/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIControl {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupLabels()
        }
    }
    
    private var separators = [UIView]()
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    var items: [String] = [] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.black {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var thumbColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var font : UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    var newBackgroundColor: UIColor = .white {
        didSet {
            self.backgroundColor = newBackgroundColor
        }
    }
    
    func setupView(){
        
        backgroundColor = newBackgroundColor
        thumbView.backgroundColor = AppearanceController.shared.mainColor
        
        setupLabels()
        setupSeparators()
        
        addIndividualItemConstraints(items: labels, mainView: self, padding: 5)
        
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels(){
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        if items.count > 0 {
            for index in 1...items.count {
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 35))
                label.text = items[index - 1]
                label.backgroundColor = UIColor.white
                label.textAlignment = .center
                label.font = UIFont(name: "Avenir-Black", size: 14)
                label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
                label.translatesAutoresizingMaskIntoConstraints = false
                label.layer.borderColor = borderColor.cgColor
                label.layer.borderWidth = borderWidth
                label.layer.masksToBounds = true
                label.layer.cornerRadius = label.frame.height / 2
                self.addSubview(label)
                labels.append(label)
            }
        }
        
        addIndividualItemConstraints(items: labels, mainView: self, padding: 5)
    }
    
    func setupSeparators() {
        for label in separators {
            label.removeFromSuperview()
        }
        
        separators.removeAll(keepingCapacity: true)
        
        if items.count > 0 {
            for _ in 1...items.count {
                
                let sep = UIView(frame: .zero)
                sep.backgroundColor = UIColor.white
                self.addSubview(sep)
                separators.append(sep)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = CGRect(x: 5, y: 5, width: self.frame.width, height: self.frame.height - 20)
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = AppearanceController.shared.mainColor
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        layoutIfNeeded()
        displayNewSelectedIndex()
        
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex(){
        for (_, item) in labels.enumerated() {
            item.textColor = unselectedLabelColor.withAlphaComponent(0.6)
            item.backgroundColor = UIColor.white
            item.layer.borderWidth = borderWidth / 2
            item.layer.borderColor = borderColor.cgColor
        }
        
        let label = labels[selectedIndex]
        label.textColor = selectedLabelColor
        label.backgroundColor = .clear
        label.layer.borderWidth = 0
        label.layer.borderColor = UIColor.clear.cgColor
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.thumbView.frame = label.frame
            
        }, completion: nil)
    }
    
    func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 10)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -10)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -padding)
                
            } else {
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: nextButton, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: padding)
                
            } else {
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    func setSelectedColors() {
        for item in labels {
            item.textColor = unselectedLabelColor
        }
        
        if labels.count > 0 {
            labels[selectedIndex].textColor = selectedLabelColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
    func setFont(){
        for item in labels {
            item.font = font
        }
    }
}
