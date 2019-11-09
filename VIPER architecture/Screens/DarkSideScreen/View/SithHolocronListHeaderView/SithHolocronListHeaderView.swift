import UIKit

class SithHolocronListHeaderView: UICollectionReusableView {
    static func loadViewFromInterfaceBuilder() -> UICollectionReusableView {
        let nib = UINib(nibName: "SithHolocronListHeaderView", bundle: .main)
        if let view = nib.instantiate(withOwner: self, options: nil)[0]
            as? UICollectionReusableView
        {
            return view
        }
        
        return UICollectionReusableView()
    }
    
}
