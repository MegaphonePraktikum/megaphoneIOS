import UIKit
import QuartzCore

@IBDesignable
public class PlayButton: UIButton {
    
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
    var favoriteColor: UIColor = UIColor(hex:"ffffff") {
        didSet {
            updateLayerProperties()
        }
    }
    
    
    
    private func updateLayerProperties() {
        if megaphoneShape != nil {
            megaphoneShape.fillColor = favoriteColor.CGColor
        }
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        createLayersIfNeeded()
        updateLayerProperties()
    }
    
    private func createLayersIfNeeded() {
        
        
        if megaphoneShape == nil {
            var starFrame = self.bounds
            starFrame.size.width = CGRectGetWidth(starFrame)
            starFrame.size.height = CGRectGetHeight(starFrame)
            
            megaphoneShape = CAShapeLayer()
            megaphoneShape.path = CGPath.rescaleForFrame(path: Paths.play, frame: starFrame)
            megaphoneShape.bounds = CGPathGetBoundingBox(megaphoneShape.path)
            megaphoneShape.fillColor = favoriteColor.CGColor
            megaphoneShape.position = CGPoint(x: CGRectGetWidth(CGPathGetBoundingBox(megaphoneShape.path))/2, y: CGRectGetHeight(CGPathGetBoundingBox(megaphoneShape.path))/2)
            megaphoneShape.transform = CATransform3DIdentity
            megaphoneShape.opacity = 1
            self.layer.addSublayer(megaphoneShape)
        }
        
        
        // Add the circleLayer to the view's layer's sublayers
        self.layer.addSublayer(circleLayer)
    }
    
    private func frameWithInset() -> CGRect {
        return CGRectInset(self.bounds, lineWidth/2, lineWidth/2)
    }
    
    
}