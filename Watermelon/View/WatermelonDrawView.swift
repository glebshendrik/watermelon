//
//  WatermelonDrawView.swift
//  Watermelon
//
//  Created by Gleb Shendrik on 28/09/2018.
//  Copyright © 2018 Gleb Shendrik. All rights reserved.
//

import UIKit

class WatermelonDrawView: UIView {
    private var circleRedPosition: CGPoint = CGPoint(x: 30.0, y: 30.0)
    private var circleRedSize: CGSize = CGSize(width: 180.0, height: 180.0)
    private var circleGreenPosition: CGPoint = CGPoint(x: 20.0, y: 20.0)
    private var circleGreenSize: CGSize = CGSize(width: 200.0, height: 200.0)
    
    var watermelonProgress: (cRS: CGSize, cGS: CGSize, cRP: CGPoint, cGP: CGPoint) {
        set {
            circleRedSize = newValue.0
            circleGreenSize = newValue.1
            circleRedPosition = newValue.2
            circleGreenPosition = newValue.3
        }
        get {
            return (circleRedSize, circleGreenSize, circleRedPosition, circleGreenPosition)
        }
    }
    override func draw(_ rect: CGRect) {
        WatermelonDraw.drawWatermelonCircle(frame: bounds, resizing: .aspectFit, circleRedSize: watermelonProgress.0, circleGreenSize: watermelonProgress.1, circleRedPosition: watermelonProgress.2, circleGreenPosition: watermelonProgress.3)
    }
}
