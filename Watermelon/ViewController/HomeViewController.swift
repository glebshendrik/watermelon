//
//  HomeViewController.swift
//  Watermelon
//
//  Created by Gleb Shendrik on 27/09/2018.
//  Copyright © 2018 Gleb Shendrik. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    lazy var WatermelonBox = WatermelonDrawView()
    var waterDrySlideValue: Int = 90
    var startingWeightSlideValue: Int = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(WatermelonBox)
        WatermelonBox.backgroundColor = .white
        WatermelonBox.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(240)
            make.center.equalTo(self.view)
        }
        
        
        self.view.addSubview(leftSliderView)
        leftSliderView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.view)
            make.width.equalTo(100)
            make.left.equalTo(self.view)
            make.height.equalTo(self.view).offset(-200)
        }
        
        self.view.addSubview(leftSlider)
        leftSlider.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.snp.height).offset(-200)
            make.edges.equalTo(leftSliderView).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.center.equalTo(leftSliderView)
            make.left.equalTo(self.view)
        }
        
        self.view.addSubview(centerSlider)
        centerSlider.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-20)
            make.width.equalTo(self.view).offset(-40)
        }
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(40)
            make.width.equalTo(self.view)
        }
        
        self.view.addSubview(titleCenterLabel)
        titleCenterLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-80)
            make.width.equalTo(self.view).offset(-40)
        }
        
        self.view.addSubview(titleWaterPercent)
        titleWaterPercent.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.view).offset(-40)
            make.bottom.equalTo(self.view).offset(-76)
            make.width.equalTo(50)
        }
        calculate(startWeight: leftSlider.value, waterDry: centerSlider.value)
    }
    
    func calculate(startWeight: Float, waterDry: Float) {
        let weightInt = Int(ceil(startWeight))
        var dryInt = Int(ceil(100 - waterDry))
        if (dryInt<1) {dryInt = 1}
        var finishWeight = weightInt / dryInt
        if (finishWeight>100) {finishWeight = 100}
        titleLabel.text = "Масса после усыхания: \(finishWeight) кг"
    }
    
    
    @objc func waterDrySlideValue(_ sender: UISlider) {
        titleWaterPercent.text = String(format: "%.0f", sender.value)
        calculate(startWeight: leftSlider.value, waterDry: sender.value)
        waterDrySlideValue = Int(sender.value)
        print(sender.value)
//        Арбузим влажность
        let rSw = (Double(WatermelonBox.watermelonProgress.cGS.width)/100)*Double(sender.value)
        let rSh = (Double(WatermelonBox.watermelonProgress.cGS.height)/100)*Double(sender.value)
        
        let rPx = 30.0+((180-rSw)/2)
        let rPy = 30.0+((180-rSh)/2)
        
        WatermelonBox.watermelonProgress  = (CGSize(width: Double(rSw), height: Double(rSh)), WatermelonBox.watermelonProgress.cGS, CGPoint(x: Double(rPx), y: Double(rPy)), WatermelonBox.watermelonProgress.cGP)
        
        WatermelonBox.setNeedsDisplay()
    }
    
    @objc func startingWeightSlideValue(_ sender: UISlider) {
        calculate(startWeight: leftSlider.value, waterDry: centerSlider.value)
        startingWeightSlideValue = Int(sender.value)
        
        let maxSize = (100 - Double(startingWeightSlideValue)) * 0.020
        let maxWidth = (2.0-maxSize)*100
        
//        Арбузим размер
        let rSw = maxWidth/100*Double(waterDrySlideValue)
        let rSh = maxWidth/100*Double(waterDrySlideValue)
        
        let rPx = 30.0+((180-rSw)/2)
        let rPy = 30.0+((180-rSh)/2)
        
        let gSw = 2.0*sender.value
        let gSh = 2.0*sender.value
        
        let gPx = 20.0+((200-gSw)/2)
        let gPy = 20.0+((200-gSh)/2)
        
        WatermelonBox.watermelonProgress  = (CGSize(width: Double(rSw), height: Double(rSh)), CGSize(width: Double(gSw), height: Double(gSh)), CGPoint(x: Double(rPx), y: Double(rPy)), CGPoint(x: Double(gPx), y: Double(gPy)))
        
        WatermelonBox.setNeedsDisplay()
    }
    
    let watermelonImageView: UIImageView = {
        let image = UIImage(named: "watermelon")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2))
        imageView.center = CGPoint(x: UIScreen.main.bounds.width/2-20, y: UIScreen.main.bounds.height/2-40)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: image!.size.height).isActive = true
        
        return imageView
    }()
    
    let leftSlider: UISlider = {
        let slider = CenterUISlider()
        
        slider.frame = CGRect(x: -150, y: 250, width: UIScreen.main.bounds.width-50, height: 35)
        slider.minimumTrackTintColor = UIColor(red: 171/255.0, green: 200/255.0, blue: 55/255.0, alpha: 1.00)
        slider.maximumTrackTintColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.00)
        //        slider.thumbTintColor = .black
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.setValue(100, animated: true)
        slider.setThumbImage(UIImage(named: "watermelon2"), for: .normal)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.frame.origin.x = 0
        slider.frame.origin.y = 0
        slider.addTarget(self, action: #selector(HomeViewController.startingWeightSlideValue(_:)), for: .valueChanged)
        
        return slider
    }()
    
    let centerSlider: UISlider = {
        let slider = CenterUISlider()
        slider.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-250, width: UIScreen.main.bounds.width-50, height: 35)
        slider.minimumTrackTintColor = UIColor(red: 171/255.0, green: 200/255.0, blue: 55/255.0, alpha: 1.00)
        slider.maximumTrackTintColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 115/255.0, alpha: 1.00)
        //        slider.thumbTintColor = .black
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.setValue(100, animated: true)
        slider.setThumbImage(UIImage(named: "watermelon1"), for: .normal)
        slider.addTarget(self, action: #selector(HomeViewController.waterDrySlideValue(_:)), for: .valueChanged)
        return slider
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Масса после усыхания: кг"
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        return label
    }()
    
    let titleCenterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Процент воды после усыхания: %"
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-350, width: UIScreen.main.bounds.width, height: 30)
        return label
    }()
    
    let titleWaterPercent: UILabel = {
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "98"
        return label
    }()
    
    let titleWeightWatermelon: UILabel = {
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Вес"
        return label
    }()
    
    let leftSliderView: UIView = {
        let leftSliderView = UIView()
        return leftSliderView
    }()
}


