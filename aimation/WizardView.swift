import UIKit

//@IBDesignable

class WizardView: UIView {
    var shaps = [CAShapeLayer]()
    weak var shapeLayer: CAShapeLayer?
    @IBOutlet weak var stackView: UIStackView!
    @IBInspectable var numberOfState: Int = 0 {
        didSet {
            initUIComponent()
        }
    }
    
    var contentView : UIView!
    var currentPosision = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        initUIComponent()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView)

    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WizardView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func initUIComponent() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
        }
        for i in 0..<numberOfState {
           let image = UIImageView()
            image.image = UIImage(named: "circle")
            image.frame.size = CGSize(width: 50, height: 50)
            stackView.insertArrangedSubview(image, at: i)
        }
    }
    
    public func next() {
        let currentImage = stackView.arrangedSubviews[currentPosision] as! UIImageView
        currentImage.image = UIImage(named: "check")
        print(currentPosision)
        if currentPosision+1 == numberOfState {
            return
        }
        let nextImage = stackView.arrangedSubviews[currentPosision + 1] as! UIImageView
    
        cp = computePoint(point: currentImage.center, add: currentImage.frame.width / 2)
        np = computePoint(point: nextImage.center, add: -(nextImage.frame.width/2))
        currentPosision += 1
        
        animate(from: cp, to: np, color: UIColor.blue.cgColor)
    }
    
    func back() {
        let nextImage = stackView.arrangedSubviews[currentPosision] as! UIImageView
        nextImage.image = UIImage(named: "circle")
        if currentPosision == 0 {
            return
        }
        if let shap = shaps.last {

            shaps.removeLast()
            
            shap.removeFromSuperlayer()

            shap.animationKeys()
            currentPosision -= 1
        }

    }
    
    func animate(from point: CGPoint, to: CGPoint, color: CGColor) {
        let path = UIBezierPath()
        path.move(to: point)
        path.addLine(to: to)
        let shapeLayer = CAShapeLayer()
       
        shapeLayer.fillColor = color
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        contentView.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.1
        animation.delegate = self
        shapeLayer.add(animation, forKey: "MyAnimation")
        shaps.append(shapeLayer)
        
    }
    var cp: CGPoint!
    var np: CGPoint!
    
    func computePoint(point: CGPoint, add: CGFloat)->CGPoint {
        let x = point.x + add
        let y = point.y
        return CGPoint(x: x, y: y)
    }
    
}

extension WizardView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}

