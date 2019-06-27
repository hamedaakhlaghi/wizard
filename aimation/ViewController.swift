//
//  ViewController.swift
//  aimation
//
//  Created by hamed akhlaghi on 6/26/19.
//  Copyright © 2019 Hamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var wizardView: WizardView!
    weak var shapeLayer: CAShapeLayer?
    var i = 0
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func back(_ sender: Any) {
        wizardView.back()
    }
    @IBAction func animate(_ sender: Any) {
        wizardView.next()
//        let image1: UIImageView!
//        let image2: UIImageView!
//        if i == 0 {
//            i = 1
//            image1 = self.image1
//            image2 = self.image2
//        }else {
//            i = 0
//            image1 = self.image2
//            image2 = self.image3
//        }
//        
//        let startPoint = computePoint(point: image1.center, add: image1.frame.width / 2)
//        let endPoint = computePoint(point: image2.center, add: -image2.frame.width/2)
//        animate(from: startPoint, to: endPoint)
    }
    
    func animate(from point: CGPoint, to: CGPoint) {
        
        // create whatever path you want
        
        let path = UIBezierPath()
        path.move(to: point)
        path.addLine(to: to)
        
        // create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.2
        animation.delegate = self
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        
        self.shapeLayer = shapeLayer
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        image2.image = UIImage(named: "check")
    }
    
    func computePoint(point: CGPoint, add: CGFloat)->CGPoint {
        let x = point.x + add
        let y = point.y
        return CGPoint(x: x, y: y)
    }
    
    
}

