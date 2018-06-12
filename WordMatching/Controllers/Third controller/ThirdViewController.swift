//
//  ThirdViewController.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/12/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    
    let internetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "You have\nUnlimited\nAccess"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackInternetUsage()
        handleTap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: createCircleShapeLayer
    fileprivate func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        // creating my track layer
        let layer = CAShapeLayer()
        // i need two pi (1 pi = 180 >> have a cercal) to get complete cercal to draw too the endAngle ..
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = fillColor.cgColor
        // using kCALineCapRound to have a nicer track
        layer.lineCap = kCALineCapRound
        layer.position = view.center
        return layer
    }
    
    
    //MARK: trackInternetUsage
    fileprivate func trackInternetUsage() {
        
        self.view.backgroundColor = .white
        //
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.5), lineWidth: 25)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        //
        let trackLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), fillColor: .clear, lineWidth: 22)
        view.layer.addSublayer(trackLayer)
        //
        shapeLayer = createCircleShapeLayer(strokeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), fillColor: .clear, lineWidth: 10)
        // transforming shapeLayer -90 degree
        shapeLayer.transform = CATransform3DMakeRotation( -CGFloat.pi/2 , 0 , 0 , 1 )
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        //
        showLabel()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    
    //MARK: handleTap
    @objc fileprivate func handleTap() {
        print("Attempting to animate")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1 // here i can play a bit to show the current usege of internet data for the user
        basicAnimation.duration = 2.2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "someBasicAnimation")
        animatePulsatingLayer()
    }
    
    
    //MARK: animatePulsatingLayer
    fileprivate func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    //MARK: showLabel
    fileprivate func showLabel() {
        view.addSubview(internetLabel)
        internetLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        internetLabel.center = view.center
    }
    
    
}

