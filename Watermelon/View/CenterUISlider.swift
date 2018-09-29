//
//  CenterUISlider.swift
//  Watermelon
//
//  Created by Gleb Shendrik on 27/09/2018.
//  Copyright © 2018 Gleb Shendrik. All rights reserved.
//

import UIKit

class CenterUISlider: UISlider {

    var trackHeight: CGFloat = 20
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
}
