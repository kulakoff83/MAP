//
//  AnnotationView.swift
//  MAP
//
//  Created by Dmitry Kulakoff on 06.10.15.
//  Copyright © 2015 Dmitriy Kulakov. All rights reserved.
//

import UIKit

@IBDesignable class AnnotationView: UIView {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var orangeView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var view: UIView!
    let nibName = "AnnotationViewXib"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //let path = self.drawBubbleButtonPath(self.frame)
        //self.borderWithPath(path)
        //self.setClippingPath(path)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    @IBAction func getEnvolvedTapped(sender: AnyObject) {
        print("tapped")//можно сделать протокол и вызвать метод который презентует контроллер
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = frame
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
//    func borderWithPath(path:UIBezierPath){
//
//        let borderPathLayer = CAShapeLayer()
//        borderPathLayer.path = path.CGPath
//        borderPathLayer.fillColor = UIColor.clearColor().CGColor
//        borderPathLayer.frame = CGRectZero
//        
//        self.layer.addSublayer(borderPathLayer)
//    }
//    
//    func setClippingPath(clippingPath : UIBezierPath)
//    {
//        if self.layer.mask == nil
//        {
//            self.layer.mask = CAShapeLayer()
//        }
//        let layer = self.layer.mask as! CAShapeLayer
//        layer.path = clippingPath.CGPath
//    }
//    
//    func drawBubbleButtonPath(frame: CGRect) -> UIBezierPath{
//        
//        //// Subframes
//        let frame2 = CGRectMake(frame.minX + floor((frame.width - 53) * 0.51020 + 0.5), frame.minY + frame.height - 33, 53, 33)
//        
//        
//        //// Bezier Drawing
//        let bezierPath = UIBezierPath()
//        bezierPath.moveToPoint(CGPointMake(frame.maxX - 6.95, frame.minY + 0.01118 * frame.height))
//        bezierPath.addLineToPoint(CGPointMake(frame.maxX - 6.56, frame.minY + 0.01237 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 1, frame.minY + 0.08239 * frame.height), controlPoint1: CGPointMake(frame.maxX - 3.98, frame.minY + 0.02421 * frame.height), controlPoint2: CGPointMake(frame.maxX - 1.94, frame.minY + 0.04985 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 0.25, frame.minY + 0.19527 * frame.height), controlPoint1: CGPointMake(frame.maxX - 0.25, frame.minY + 0.11220 * frame.height), controlPoint2: CGPointMake(frame.maxX - 0.25, frame.minY + 0.13989 * frame.height))
//        bezierPath.addLineToPoint(CGPointMake(frame.maxX - 0.25, frame.maxY - 29.54))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 0.9, frame.maxY - 20.95), controlPoint1: CGPointMake(frame.maxX - 0.25, frame.maxY - 25.13), controlPoint2: CGPointMake(frame.maxX - 0.25, frame.maxY - 22.93))
//        bezierPath.addLineToPoint(CGPointMake(frame.maxX - 1, frame.maxY - 20.56))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 6.56, frame.maxY - 15), controlPoint1: CGPointMake(frame.maxX - 1.94, frame.maxY - 17.98), controlPoint2: CGPointMake(frame.maxX - 3.98, frame.maxY - 15.94))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 15.54, frame.maxY - 14.25), controlPoint1: CGPointMake(frame.maxX - 8.93, frame.maxY - 14.25), controlPoint2: CGPointMake(frame.maxX - 11.13, frame.maxY - 14.25))
//        bezierPath.addLineToPoint(CGPointMake(frame2.minX + 40.62, frame2.minY + 18.75))
//        bezierPath.addCurveToPoint(CGPointMake(frame2.minX + 34.25, frame2.minY + 26.25), controlPoint1: CGPointMake(frame2.minX + 38.16, frame2.minY + 21.21), controlPoint2: CGPointMake(frame2.minX + 36.03, frame2.minY + 24.03))
//        bezierPath.addCurveToPoint(CGPointMake(frame2.minX + 30.25, frame2.minY + 30.75), controlPoint1: CGPointMake(frame2.minX + 32.72, frame2.minY + 28.16), controlPoint2: CGPointMake(frame2.minX + 31.46, frame2.minY + 29.54))
//        bezierPath.addCurveToPoint(CGPointMake(frame2.minX + 26.62, frame2.minY + 32.75), controlPoint1: CGPointMake(frame2.minX + 28.92, frame2.minY + 32.08), controlPoint2: CGPointMake(frame2.minX + 27.69, frame2.minY + 32.75))
//        bezierPath.addCurveToPoint(CGPointMake(frame2.minX + 23.25, frame2.minY + 30.75), controlPoint1: CGPointMake(frame2.minX + 25.55, frame2.minY + 32.75), controlPoint2: CGPointMake(frame2.minX + 24.58, frame2.minY + 32.08))
//        bezierPath.addCurveToPoint(CGPointMake(frame2.minX + 12.62, frame2.minY + 18.75), controlPoint1: CGPointMake(frame2.minX + 20.63, frame2.minY + 28.13), controlPoint2: CGPointMake(frame2.minX + 17.2, frame2.minY + 23.33))
//        bezierPath.addLineToPoint(CGPointMake(frame.minX + 16.04, frame.maxY - 14.25))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 7.45, frame.maxY - 14.9), controlPoint1: CGPointMake(frame.minX + 11.63, frame.maxY - 14.25), controlPoint2: CGPointMake(frame.minX + 9.43, frame.maxY - 14.25))
//        bezierPath.addLineToPoint(CGPointMake(frame.minX + 7.06, frame.maxY - 15))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1.5, frame.maxY - 20.56), controlPoint1: CGPointMake(frame.minX + 4.48, frame.maxY - 15.94), controlPoint2: CGPointMake(frame.minX + 2.44, frame.maxY - 17.98))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 0.75, frame.maxY - 29.54), controlPoint1: CGPointMake(frame.minX + 0.75, frame.maxY - 22.93), controlPoint2: CGPointMake(frame.minX + 0.75, frame.maxY - 25.13))
//        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.75, frame.minY + 0.19527 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 1.4, frame.minY + 0.08723 * frame.height), controlPoint1: CGPointMake(frame.minX + 0.75, frame.minY + 0.13989 * frame.height), controlPoint2: CGPointMake(frame.minX + 0.75, frame.minY + 0.11220 * frame.height))
//        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.5, frame.minY + 0.08239 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 7.06, frame.minY + 0.01237 * frame.height), controlPoint1: CGPointMake(frame.minX + 2.44, frame.minY + 0.04985 * frame.height), controlPoint2: CGPointMake(frame.minX + 4.48, frame.minY + 0.02421 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.minX + 16.04, frame.minY + 0.00294 * frame.height), controlPoint1: CGPointMake(frame.minX + 9.43, frame.minY + 0.00294 * frame.height), controlPoint2: CGPointMake(frame.minX + 11.63, frame.minY + 0.00294 * frame.height))
//        bezierPath.addLineToPoint(CGPointMake(frame.maxX - 15.54, frame.minY + 0.00294 * frame.height))
//        bezierPath.addCurveToPoint(CGPointMake(frame.maxX - 6.95, frame.minY + 0.01118 * frame.height), controlPoint1: CGPointMake(frame.maxX - 11.13, frame.minY + 0.00294 * frame.height), controlPoint2: CGPointMake(frame.maxX - 8.93, frame.minY + 0.00294 * frame.height))
//        bezierPath.closePath()
//
//        return bezierPath
//    }
}
