//
//  CardView.swift
//  CardViewswift
//
//  Created by muruganandam on 27/02/18.
//  Copyright © 2018 muruganandam. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerradius : CGFloat = 2
    @IBInspectable var shadowOffsetWidth : CGFloat = 0
    @IBInspectable var shadowOffsetheight : CGFloat = 5
    @IBInspectable var shadowcolor : UIColor = UIColor.black
    @IBInspectable var shadowOpacity : CGFloat = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerradius
        layer.shadowColor = shadowcolor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetheight)
        let shadowpath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowpath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
   
}
