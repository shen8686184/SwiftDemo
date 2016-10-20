

import UIKit



class ViewController : UIViewController {
    var sprite : CALayer!
    lazy var images : [UIImage] = self.makeImages()
    
    func makeImages () -> [UIImage] {
        var arr = [UIImage]()
        // replace C for loops by stride
        for i in stride(from: 0, to: 3, by: 1) { // (var i = 0; i < 3; i++) {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 24,height: 24), true, 0)
            UIImage(named: "sprites.png")!.draw(at: CGPoint(x: CGFloat(-(5+i)*24), y: -7*24/*0-4*24*/))
            let im = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        for i in stride(from: 1, through: 0, by: -1) { // (var i = 1; i >= 0; i--) {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 24,height: 24), true, 0)
            UIImage(named: "sprites.png")!.draw(at: CGPoint(x: CGFloat(-(5+i)*24), y: -7*24/*0-4*24*/))
            let im = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return arr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sprite = CALayer()
        self.sprite.frame = CGRect(x: 30,y: 30,width: 24,height: 24)
        self.sprite.contentsScale = UIScreen.main.scale
        self.view.layer.addSublayer(self.sprite)
        self.sprite.contents = self.images[0].cgImage
        
    }
    
    @IBAction func doButton(_ sender:AnyObject?) {

        let anim = CAKeyframeAnimation(keyPath:"contents")
        anim.values = self.images.map {$0.cgImage!}
        anim.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        anim.calculationMode = kCAAnimationDiscrete
        anim.duration = 1.5
        anim.repeatCount = Float.infinity
        
        let anim2 = CABasicAnimation(keyPath:"position")
        anim2.duration = 10
        anim2.toValue = NSValue(cgPoint: CGPoint(x: 350,y: 30))
        
        let group = CAAnimationGroup()
        group.animations = [anim, anim2]
        group.duration = 10
        
        self.sprite.add(group, forKey:nil)

        
    }
    
}
