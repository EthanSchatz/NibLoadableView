import UIKit

class NibLoadableView: UIView {
    // MARK: - Components
    private var view: UIView!
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.nibSetup()
        self.initialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
        self.initialSetup()
    }
    
    // MARK: - Private
    private func nibSetup() {
        self.view = self.loadViewFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(self.view)
    }
    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        guard let view = nib.instantiateWithOwner(self, options: nil).first as? UIView else { fatalError("Could not load view from nib") }
        return view
    }
    
    // MARK: - Override Points
    internal func initialSetup() { }
    internal var nibName: String { return String(self.dynamicType) }
}

// NOTE: By default the .xib has the same name as the class
//      in this instance MyView.xib
//      To use it in interface builder simply add a `UIView` and change its class to `MyView`
//
//      To use a different .xib, override `nibName`
//​
//class MyView: NibLoadableView {
//    @IBOutlet private var someLabel: UILabel!
//    @IBOutlet private var someButon: UIButton!
//    
//    override func initialSetup() {
//        //do one time setup stuff here
//        self.backgroundColor = .redColor()
//    }
//}
