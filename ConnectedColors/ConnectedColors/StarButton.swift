//
//  StatButton.swift
//  FavoriteStar
//
//  Created by Rafael Machado on 14/11/14.
//  Copyright (c) 2014 Rafael Machado. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class StarButton: UIButton {
    
    private var starShape: CAShapeLayer!
    private var outerRingShape: CAShapeLayer!
    private var fillRingShape: CAShapeLayer!
    
    private let starKey = "FAVANIMKEY"
    private let favoriteKey = "FAVORITE"
    private let notFavoriteKey = "NOTFAVORITE"
    
    @IBInspectable
    var lineWidth: CGFloat = 1 {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var favoriteColor: UIColor = UIColor(hex:"ee7034") {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var notFavoriteColor: UIColor = UIColor(hex:"ffffff") {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var starFavoriteColor: UIColor = UIColor(hex:"ffffff") {
        didSet {
            updateLayerProperties()
        }
    }
    
    var isFavorite : Bool = false {
        didSet {
            if self.isFavorite {
                favorite()
            }else {
                notFavorite()
            }
        }
    }
    
    private func updateLayerProperties() {
        if fillRingShape != nil {
            fillRingShape.fillColor = favoriteColor.CGColor
        }
        
        if outerRingShape != nil {
            outerRingShape.lineWidth = lineWidth
            outerRingShape.strokeColor = favoriteColor.CGColor
        }
        
        if starShape != nil {
            if isFavorite {
                starShape.fillColor = starFavoriteColor.CGColor
            } else {
                starShape.fillColor = notFavoriteColor.CGColor
            }
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        createLayersIfNeeded()
        updateLayerProperties()
    }
    
    private func createLayersIfNeeded() {
        if fillRingShape == nil {
            fillRingShape = CAShapeLayer()
            fillRingShape.path = Paths.circle(frameWithInset())
            fillRingShape.bounds = CGPathGetBoundingBox(fillRingShape.path)
            fillRingShape.fillColor = favoriteColor.CGColor
            fillRingShape.lineWidth = lineWidth
            fillRingShape.position = CGPoint(x: CGRectGetWidth(fillRingShape.bounds)/2, y: CGRectGetHeight(fillRingShape.bounds)/2)
            fillRingShape.transform = CATransform3DMakeScale(1, 1, 1)
            fillRingShape.opacity = 1
            
            
            
            var gradientMask = CAShapeLayer();
            gradientMask.fillColor = UIColor.clearColor().CGColor;
            gradientMask.strokeColor = UIColor.blackColor().CGColor;
            gradientMask.lineWidth = 4;
            gradientMask.frame = CGRectMake(0, 0, 100, 100);
            
            var t = CGPathCreateMutable();
            CGPathMoveToPoint(t, nil, 0, 0);
            CGPathAddLineToPoint(t, nil, 100, 100);
            
            gradientMask.path = t;
            
            
            var gradientLayer = CAGradientLayer();
            gradientLayer.startPoint = CGPointMake(0.5,1.0);
            gradientLayer.endPoint = CGPointMake(0.5,0.0);
            gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(fillRingShape.bounds), CGRectGetHeight(fillRingShape.bounds));
            var colors = NSMutableArray();
            for (var i : CGFloat = 0; i < 10; i++) {
                colors.addObject(UIColor(hue: 0.08, saturation: 1, brightness: (i/20)+0.4, alpha: 1).CGColor)
                
            }
            gradientLayer.colors = colors;
            
            gradientLayer.mask = fillRingShape
            
            
            
        
            
            
            
            self.layer.addSublayer(gradientLayer)
        }
        if outerRingShape == nil {
            outerRingShape = CAShapeLayer()
            outerRingShape.path = Paths.circle(frameWithInset())
            outerRingShape.bounds = frameWithInset()
            outerRingShape.lineWidth = lineWidth
            outerRingShape.strokeColor = favoriteColor.CGColor
            outerRingShape.fillColor = UIColor.clearColor().CGColor
            outerRingShape.position = CGPoint(x: CGRectGetWidth(self.bounds)/2, y: CGRectGetHeight(self.bounds)/2)
            outerRingShape.transform = CATransform3DIdentity
            outerRingShape.opacity = 1.0
            self.layer.addSublayer(outerRingShape)
        }
        if starShape == nil {
            var starFrame = self.bounds
            starFrame.size.width = CGRectGetWidth(starFrame)/2.5
            starFrame.size.height = CGRectGetHeight(starFrame)/2.5
            
            starShape = CAShapeLayer()
            starShape.path = CGPath.rescaleForFrame(path: Paths.star, frame: starFrame)
            starShape.bounds = CGPathGetBoundingBox(starShape.path)
            starShape.fillColor = notFavoriteColor.CGColor
            starShape.position = CGPoint(x: CGRectGetWidth(CGPathGetBoundingBox(outerRingShape.path))/2, y: CGRectGetHeight(CGPathGetBoundingBox(outerRingShape.path))/2)
            starShape.transform = CATransform3DIdentity
            starShape.opacity = 1
            self.layer.addSublayer(starShape)
        }
    }
    
    private func frameWithInset() -> CGRect {
        return CGRectInset(self.bounds, lineWidth/2, lineWidth/2)
    }
    
    private func notFavorite(){
        let starFillColor = CABasicAnimation(keyPath: "fillColor")
        starFillColor.toValue = notFavoriteColor.CGColor
        starFillColor.duration = 0.3
        
        let starOpacity = CABasicAnimation(keyPath: "opacity")
        starOpacity.toValue = 1
        starOpacity.duration = 3.3
        
        let starGroup = CAAnimationGroup()
        starGroup.animations = [starFillColor, starOpacity]
        
        starShape.addAnimation(starGroup, forKey: nil)
        starShape.fillColor = notFavoriteColor.CGColor
        starShape.opacity = 1
        
        let fillCircle = CABasicAnimation(keyPath: "opacity")
        fillCircle.toValue = 1
        fillCircle.duration = 0.3
        fillCircle.setValue(notFavoriteKey, forKey: starKey)
        fillCircle.delegate = self
        
        fillRingShape.addAnimation(fillCircle, forKey: nil)
        fillRingShape.opacity = 1
        
        let outerCircle = CABasicAnimation(keyPath: "opacity")
        outerCircle.toValue = 0.5
        outerCircle.duration = 0.3
        
        outerRingShape.addAnimation(outerCircle, forKey: nil)
        outerRingShape.opacity = 0.5
        
    }
    
    private func favorite(){
        var starGoUp = CATransform3DIdentity
        starGoUp = CATransform3DScale(starGoUp, 1.5, 1.5, 1.5)
        var starGoDown = CATransform3DIdentity
        starGoDown = CATransform3DScale(starGoDown, 0.01, 0.01, 0.01)
        
        let starKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        starKeyFrames.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:starGoUp),NSValue(CATransform3D:starGoDown)]
        starKeyFrames.keyTimes = [0.0,0.4,0.6]
        starKeyFrames.duration = 0.4
        starKeyFrames.beginTime = CACurrentMediaTime() + 0.05
        starKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        starKeyFrames.fillMode =  kCAFillModeBackwards
        starKeyFrames.setValue(favoriteKey, forKey: starKey)
        starKeyFrames.delegate = self
        
        starShape.addAnimation(starKeyFrames, forKey: favoriteKey)
        starShape.transform = starGoDown
        
        var grayGoUp = CATransform3DIdentity
        grayGoUp = CATransform3DScale(grayGoUp, 1.5, 1.5, 1.5)
        var grayGoDown = CATransform3DIdentity
        grayGoDown = CATransform3DScale(grayGoDown, 0.01, 0.01, 0.01)
        
        let outerCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        outerCircleAnimation.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:grayGoUp),NSValue(CATransform3D:grayGoDown)]
        outerCircleAnimation.keyTimes = [0.0,0.4,0.6]
        outerCircleAnimation.duration = 0.4
        outerCircleAnimation.beginTime = CACurrentMediaTime() + 0.01
        outerCircleAnimation.fillMode =  kCAFillModeBackwards
        outerCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        outerRingShape.addAnimation(outerCircleAnimation, forKey: "Gray circle Animation")
        outerRingShape.transform = grayGoDown
        
        var favoriteFillGrow = CATransform3DIdentity
        favoriteFillGrow = CATransform3DScale(favoriteFillGrow, 0.8, 0.8, 0.8)
        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        fillCircleAnimation.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:favoriteFillGrow)]
        fillCircleAnimation.keyTimes = [0.0,0.0,0.5]
        fillCircleAnimation.duration = 0.5
        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        fillCircleAnimation.fillMode =  kCAFillModeBackwards
        
        let favoriteFillOpacity = CABasicAnimation(keyPath: "opacity")
        favoriteFillOpacity.toValue = 1
        favoriteFillOpacity.duration = 1
        favoriteFillOpacity.beginTime = CACurrentMediaTime()
        favoriteFillOpacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        favoriteFillOpacity.fillMode =  kCAFillModeBackwards
        
        fillRingShape.addAnimation(favoriteFillOpacity, forKey: "Show fill circle")
        fillRingShape.addAnimation(fillCircleAnimation, forKey: "fill circle Animation")
        fillRingShape.transform = CATransform3DIdentity
    }
    
    override public func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let key = anim.valueForKey(starKey) as? String {
            switch(key) {
            case (favoriteKey):
                endFavorite()
            case (notFavoriteKey):
                prepareForFavorite()
            default:
                break
            }
        }
        enableTouch()
    }
    
    private func endFavorite() {
        
        executeWithoutActions {
            self.starShape.fillColor = self.starFavoriteColor.CGColor
            self.starShape.opacity = 1
            self.fillRingShape.opacity = 1
            self.fillRingShape.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
            self.outerRingShape.transform = CATransform3DIdentity
            self.outerRingShape.opacity = 0
        }
        
        let starAnimations = CAAnimationGroup()
        var starGoUp = CATransform3DIdentity
        starGoUp = CATransform3DScale(starGoUp, 2, 2, 2)
        
        let starKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        starKeyFrames.values = [NSValue(CATransform3D: starShape.transform),NSValue(CATransform3D:starGoUp),NSValue(CATransform3D:CATransform3DIdentity)]
        starKeyFrames.keyTimes = [0.0,0.4,0.6]
        starKeyFrames.duration = 0.2
        starKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        starShape.addAnimation(starKeyFrames, forKey: nil)
        starShape.transform = CATransform3DIdentity
    }
    
    private func prepareForFavorite() {
        executeWithoutActions {
            self.fillRingShape.opacity = 1
            self.fillRingShape.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    private func executeWithoutActions(closure: () -> ()) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        closure()
        CATransaction.commit()
    }
    
    override public func animationDidStart(anim: CAAnimation!) {
        disableTouch()
    }
    
    private func disableTouch() {
        self.userInteractionEnabled = false
    }
    
    private func enableTouch() {
        self.userInteractionEnabled = true
    }
}