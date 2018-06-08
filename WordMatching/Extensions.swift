//
//  Extensions.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/8/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addCustomization(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
    }
    
}
