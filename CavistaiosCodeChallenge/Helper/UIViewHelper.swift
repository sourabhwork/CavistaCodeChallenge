//
//  UIViewHelper.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 12/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
            
    func setRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
       
    func addShadowToView(opacity: Float = 0.5) {
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
    }
   
}
