import UIKit

class SithHolocronListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var powersLabel: UILabel!
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    
    static func loadViewFromInterfaceBuilder() -> UICollectionViewCell {
        let nib = UINib(nibName: "SithHolocronListCollectionViewCell", bundle: .main)
        if let view = nib.instantiate(withOwner: self, options: nil)[0]
            as? UICollectionViewCell
        {
            return view
        }
        
        return UICollectionViewCell()
    }
    
}
