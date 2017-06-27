//
//  BezierView.swift
//  TestApp
//
//  Created by nabinrai on 6/14/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit
import MapKit

enum BubbleDirection{
    case right,left,up,down,rightDown,rightUp,leftDown,leftUp
}

class BezierView: UIView {
    
    var path: UIBezierPath!
    var bubbleDirection: BubbleDirection? = .right
    var bubbleRadiusMultiplier: CGFloat? = 0.8
    var arrowLength: CGFloat? = 25
    
    let imageForCallOut: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "cartoon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let msgLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .blue
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func draw(_ rect: CGRect) {
        
        self.createBubbleView()
        self.addViews()
        
        
        
    }
    
    func createBubbleView(){
        let centerPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.width / 2)
        var startValue: CGFloat!
        var endValue: CGFloat!
        var linePoint: CGPoint!
        
        switch self.bubbleDirection! {
            
        case .up:
            startValue = (10 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (-10 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x:self.frame.width/2, y: 0)
            break
        case .down:
            startValue = (190 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (170 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: self.frame.width/2, y: self.frame.height)
            break
        case .right:
            startValue = (100 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (80 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: self.frame.width, y: self.frame.height/2)
            break
        case .left:
            startValue = (280 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (260 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: 0, y: self.frame.height/2)
            break
        case .rightDown:
            startValue = (145 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (125 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: self.frame.width-arrowLength!, y: self.frame.height-arrowLength!)
            break
        case .rightUp:
            startValue = (55 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (35 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: self.frame.width-arrowLength!, y: 0+arrowLength!)
            break
        case .leftDown:
            startValue = (235 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (215 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: 0+arrowLength!, y: self.frame.height-arrowLength!)
            break
        case .leftUp:
            startValue = (325 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            endValue = (305 * 2 * CGFloat(Double.pi)) / 360 - CGFloat(Double.pi/2)
            linePoint = CGPoint(x: 0+arrowLength!, y: 0+arrowLength!)
            break
       
        }
        path = UIBezierPath()
        path.addArc(withCenter: centerPoint, radius: (self.frame.width/2)*bubbleRadiusMultiplier!, startAngle: startValue, endAngle: endValue, clockwise: true)
        path.addLine(to: linePoint)
        path.close()
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = UIColor.white.cgColor
        sliceLayer.backgroundColor = nil
        sliceLayer.strokeColor = UIColor.purple.cgColor
        sliceLayer.lineWidth = 1.0
        
        
        
        self.layer.addSublayer(sliceLayer)
        
        
    }
    
    func taPtaP(){
        
        
    }
    
    func addViews(){
        self.addSubview(imageForCallOut)
        
        imageForCallOut.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant:0).isActive = true
        imageForCallOut.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:-20).isActive = true
        imageForCallOut.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        imageForCallOut.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
        self.imageForCallOut.layer.cornerRadius = self.imageForCallOut.frame.size.width / 2;
        self.imageForCallOut.clipsToBounds = true
        
        self.addSubview(msgLabel)
        msgLabel.topAnchor.constraint(equalTo: imageForCallOut.bottomAnchor, constant: 2).isActive = true
        msgLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        msgLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        msgLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    
    /// check the direction of bubbleview for call out
    
    func manageBubbleView(view:MKAnnotationView){
        //let calloutView = BezierView()
       // let annotation = view.annotation
        let heightOfBubble: CGFloat = 180
        let widthOfBubble = heightOfBubble
        var xAnchor:NSLayoutConstraint?
        var yAnchor:NSLayoutConstraint?
        // calloutView.restaurantLogo.image =
        self.translatesAutoresizingMaskIntoConstraints = false
       // self.bubbleDirection = .rightDown
        
        switch self.bubbleDirection! {
        case .left:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:widthOfBubble/2)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            break
        case .right:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:-widthOfBubble/2)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            break
        case .up:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:widthOfBubble/2)
            break
        case .down:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:-widthOfBubble/2)
            break
        case .rightDown:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor ,constant:-widthOfBubble/2+arrowLength!)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:-heightOfBubble/2+arrowLength!)
            break
        case .rightUp:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor ,constant:-widthOfBubble/2+arrowLength!)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:heightOfBubble/2-arrowLength!)
            break
        case .leftUp:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor ,constant:widthOfBubble/2-arrowLength!)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:heightOfBubble/2-arrowLength!)
            break
        case .leftDown:
            xAnchor = self.centerXAnchor.constraint(equalTo: view.centerXAnchor ,constant:widthOfBubble/2-arrowLength!)
            yAnchor = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:-heightOfBubble/2+arrowLength!)
            break
            
        }
        view.addSubview(self)
        self.widthAnchor.constraint(equalToConstant: widthOfBubble).isActive = true
        self.heightAnchor.constraint(equalToConstant: heightOfBubble).isActive = true
        xAnchor!.isActive = true
        yAnchor!.isActive = true
        
    }
    

    
    
    
    
}
