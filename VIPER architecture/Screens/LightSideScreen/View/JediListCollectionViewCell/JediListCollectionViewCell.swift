import UIKit

class JediListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var apprenticesLabel: UILabel!
    @IBOutlet weak var subtitleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitleLabelTrailingConstraint: NSLayoutConstraint!

    static func loadViewFromInterfaceBuilder() -> UICollectionViewCell {
        let nib = UINib(nibName: "JediListCollectionViewCell", bundle: .main)
        if let view = nib.instantiate(withOwner: self, options: nil)[0]
            as? UICollectionViewCell
        {
            return view
        }
        
        return UICollectionViewCell()
    }

}
