
import UIKit
import QuartzCore

@IBDesignable
public class MegaphoneButton: UIButton {
    
    private var megaphoneShape: CAShapeLayer!
    private var outerRingShape: CAShapeLayer!
    private var fillRingShape: CAShapeLayer!
    private var circleLayer: CAShapeLayer!
    
    private let starKey = "FAVANIMKEY"
    private let favoriteKey = "FAVORITE"
    private let notFavoriteKey = "NOTFAVORITE"
    
    private var timer : NSTimer!
    private var val = 0.0;
    
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
    
    var isActive : Bool = false {
        didSet {
            println("isvaforite")
            if self.isActive {
                activate()
            }else {
                deactivate()
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
        
        if megaphoneShape != nil {
            if isActive {
                megaphoneShape.fillColor = starFavoriteColor.CGColor
            } else {
                megaphoneShape.fillColor = notFavoriteColor.CGColor
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
            gradientLayer.colors = colors as [AnyObject];
            
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
        if megaphoneShape == nil {
            var starFrame = self.bounds
            starFrame.size.width = CGRectGetWidth(starFrame)/2.5
            starFrame.size.height = CGRectGetHeight(starFrame)/2.5
            
            megaphoneShape = CAShapeLayer()
            megaphoneShape.path = CGPath.rescaleForFrame(path: Paths.megaphone, frame: starFrame)
            megaphoneShape.bounds = CGPathGetBoundingBox(megaphoneShape.path)
            megaphoneShape.fillColor = notFavoriteColor.CGColor
            megaphoneShape.position = CGPoint(x: CGRectGetWidth(CGPathGetBoundingBox(outerRingShape.path))/2, y: CGRectGetHeight(CGPathGetBoundingBox(outerRingShape.path))/2)
            megaphoneShape.transform = CATransform3DIdentity
            megaphoneShape.opacity = 1
            self.layer.addSublayer(megaphoneShape)
        }
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: -CGFloat(M_PI * 0.5), endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 0.7).CGColor
        circleLayer.lineWidth = 10.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        self.layer.addSublayer(circleLayer)
    }
    
    private func frameWithInset() -> CGRect {
        return CGRectInset(self.bounds, lineWidth/2, lineWidth/2)
    }
    
    private func deactivate(){
        println("NOTFAV func")
        
        let starFillColor = CABasicAnimation(keyPath: "fillColor")
        starFillColor.toValue = notFavoriteColor.CGColor
        starFillColor.duration = 0.4
        
        let starOpacity = CABasicAnimation(keyPath: "opacity")
        starOpacity.toValue = 1
        starOpacity.duration = 0.4
        
        let starGroup = CAAnimationGroup()
        starGroup.animations = [starFillColor, starOpacity]
        
        megaphoneShape.addAnimation(starGroup, forKey: nil)
        megaphoneShape.fillColor = notFavoriteColor.CGColor
        megaphoneShape.opacity = 1
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = CGFloat(-(M_PI * 0.1))
        rotateAnimation.toValue = 0.0
        rotateAnimation.duration = 0.4
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode =  kCAFillModeForwards
        
        megaphoneShape.addAnimation(rotateAnimation, forKey: favoriteKey)
        
        
        let fillCircle = CABasicAnimation(keyPath: "opacity")
        fillCircle.toValue = 1
        fillCircle.duration = 0.4
        fillCircle.setValue(notFavoriteKey, forKey: starKey)
        fillCircle.delegate = self
        
        var favoriteFillGrow = CATransform3DIdentity
        favoriteFillGrow = CATransform3DScale(favoriteFillGrow, 0.8, 0.8, 0.8)
        var favoriteFillGrow2 = CATransform3DIdentity
        favoriteFillGrow2 = CATransform3DScale(favoriteFillGrow2, 1.0, 1.0, 1.0)
        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        fillCircleAnimation.values = [NSValue(CATransform3D:favoriteFillGrow),NSValue(CATransform3D:favoriteFillGrow2),NSValue(CATransform3D:favoriteFillGrow)]
        fillCircleAnimation.keyTimes = [0.0,0.4,0.4]
        fillCircleAnimation.duration = 0.4
        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
        fillCircleAnimation.removedOnCompletion = false
        
        fillCircleAnimation.fillMode =  kCAFillModeForwards
        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        
        let favFill = CABasicAnimation(keyPath: "transform.scale")
        favFill.fromValue = 0.8
        favFill.toValue = 1.0
        favFill.duration = 0.4
        favFill.removedOnCompletion = false
        favFill.fillMode = kCAFillModeForwards
        
        fillRingShape.addAnimation(favFill, forKey: favoriteKey)
        
        let outerCircle = CABasicAnimation(keyPath: "opacity")
        outerCircle.toValue = 0.5
        outerCircle.duration = 0.4
        
        outerRingShape.addAnimation(outerCircle, forKey: nil)
        outerRingShape.opacity = 0.4
        
        
        
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = 1.0
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0.0
        animation.toValue = 0.0
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        //circleLayer.strokeEnd = 1.0
        
        
        // Do the actual animation
        circleLayer.addAnimation(animation, forKey: favoriteKey)
        
        
    }
    
    private func activate(){
        println("FAV Func")
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        var starGoUp = CATransform3DIdentity
        starGoUp = CATransform3DScale(starGoUp, 0.01, 0.01, 0.01)
        var starGoDown = CATransform3DIdentity
        starGoDown = CATransform3DScale(starGoDown, 0.01, 0.01, 0.01)
        
        var grayGoUp = CATransform3DIdentity
        grayGoUp = CATransform3DScale(grayGoUp, 1.5, 1.5, 1.5)
        var grayGoDown = CATransform3DIdentity
        grayGoDown = CATransform3DScale(grayGoDown, 0.01, 0.01, 0.01)
        
        let outerCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        outerCircleAnimation.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:grayGoUp),NSValue(CATransform3D:grayGoDown)]
        outerCircleAnimation.keyTimes = [0.0,0.4,0.8]
        outerCircleAnimation.duration = 0.4
        outerCircleAnimation.beginTime = CACurrentMediaTime() + 0.01
        outerCircleAnimation.fillMode =  kCAFillModeBackwards
        outerCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        outerRingShape.addAnimation(outerCircleAnimation, forKey: "Gray circle Animation")
        outerRingShape.transform = grayGoDown
        
        var favoriteFillGrow = CATransform3DIdentity
        favoriteFillGrow = CATransform3DScale(favoriteFillGrow, 0.8, 0.8, 0.8)
        var favoriteFillGrow2 = CATransform3DIdentity
        favoriteFillGrow2 = CATransform3DScale(favoriteFillGrow2, 0.8, 0.8, 0.8)
        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        fillCircleAnimation.values = [NSValue(CATransform3D:CATransform3DIdentity),NSValue(CATransform3D:favoriteFillGrow2),NSValue(CATransform3D:favoriteFillGrow)]
        fillCircleAnimation.keyTimes = [0.0,0.4,0.4]
        fillCircleAnimation.duration = 0.4
        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
        fillCircleAnimation.removedOnCompletion = false
        
        fillCircleAnimation.fillMode =  kCAFillModeForwards
        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let favFill = CABasicAnimation(keyPath: "transform.scale")
        favFill.fromValue = 1
        favFill.toValue = 0.8
        favFill.duration = 0.4
        favFill.removedOnCompletion = false
        favFill.fillMode = kCAFillModeForwards
        
        fillRingShape.addAnimation(favFill, forKey: favoriteKey)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(-(M_PI * 0.1))
        rotateAnimation.duration = 0.4
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode =  kCAFillModeForwards
        
        megaphoneShape.addAnimation(rotateAnimation, forKey: favoriteKey)
        
        
        let favoriteFillOpacity = CABasicAnimation(keyPath: "opacity")
        favoriteFillOpacity.toValue = 1
        favoriteFillOpacity.duration = 1
        favoriteFillOpacity.beginTime = CACurrentMediaTime()
        favoriteFillOpacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        favoriteFillOpacity.fillMode =  kCAFillModeBackwards
        
        fillRingShape.addAnimation(favoriteFillOpacity, forKey: "Show fill circle")
        //fillRingShape.addAnimation(fillCircleAnimation, forKey: "fill circle Animation")
        fillRingShape.transform = CATransform3DIdentity
        
    }
    
    func update() {
        
        if(isActive){
            // We want to animate the strokeEnd property of the circleLayer
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            
            // Set the animation duration appropriately
            animation.duration = 1.0
            
            // Animate from 0 (no circle) to 1 (full circle)
            animation.fromValue = val
            animation.toValue = val + 0.1
            
            val += 0.1
            
            // Do a linear animation (i.e. the speed of the animation stays the same)
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            
            // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
            // right value when the animation ends.
            //circleLayer.strokeEnd = 1.0
            
            
            // Do the actual animation
            circleLayer.addAnimation(animation, forKey: favoriteKey)
            
        } else {
            
            timer.invalidate()
            
            val = 0.0
        }
        
    }

}