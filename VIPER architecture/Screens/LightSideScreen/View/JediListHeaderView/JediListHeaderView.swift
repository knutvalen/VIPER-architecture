import UIKit

class JediListHeaderView: UICollectionReusableView {
    static func loadViewFromInterfaceBuilder() -> UICollectionReusableView {
        let nib = UINib(nibName: "JediListHeaderView", bundle: .main)
        if let view = nib.instantiate(withOwner: self, options: nil)[0]
            as? UICollectionReusableView
        {
            return view
        }
        
        return UICollectionReusableView()
    }
    
}
