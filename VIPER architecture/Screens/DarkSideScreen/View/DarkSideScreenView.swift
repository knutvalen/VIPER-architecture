import UIKit

class DarkSideScreenView: UIViewController {
    private var darkSideScreenPresenter: DarkSideScreenPresenterType?
    @IBOutlet weak var darkSideTitle: UILabel!
    @IBOutlet weak var sithCodeTitle: UILabel!
    @IBOutlet weak var sithCodeRules: UILabel!
    @IBOutlet weak var sithHolocronListCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "darkSideView"
        darkSideTitle.text = nil
        sithCodeTitle.text = nil
        sithCodeRules.text = nil
        activityIndicator.isHidden = true
        sithHolocronListCollectionView.register(
            UINib(
                nibName: "SithHolocronListCollectionViewCell",
                bundle: .main),
            forCellWithReuseIdentifier: "SithHolocronCell"
        )
        sithHolocronListCollectionView.register(
            UINib(
                nibName: "SithHolocronListHeaderView",
                bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SithHolocronListHeader"
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Light side",
            style: .plain,
            target: self,
            action: #selector(onLightSideSelected)
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    private func updateHolocronCell(
        _ sithHolocronListCollectionViewCell: SithHolocronListCollectionViewCell,
        holocron: DarkSideScreenEntityType.SithHolocron
    ) -> SithHolocronListCollectionViewCell {
        var powersText = ""
        if let powers = holocron.powers {
            for power in powers {
                if powersText.isEmpty == false {
                    powersText += ", "
                }
                
                powersText += power
            }
        }
        
        sithHolocronListCollectionViewCell.nameLabel.text = holocron.name
        
        if let creator = holocron.creator {
            sithHolocronListCollectionViewCell.creatorLabel.text = "Created by " + creator
        } else {
            sithHolocronListCollectionViewCell.creatorLabel.text = "Unknown creator"
        }
        
        if holocron.powers?.count == 0 || holocron.powers == nil {
            powersText = "Unknown powers"
        }
        
        sithHolocronListCollectionViewCell.powersLabel.text = powersText
        
        return sithHolocronListCollectionViewCell
    }
    
    @objc
    private func onLightSideSelected(_ sender: UIButton) {
        presenter?.onLightSideSelected()
    }
    
}

extension DarkSideScreenView: DarkSideScreenViewType {
    var presenter: DarkSideScreenPresenterType? {
        get {
            return darkSideScreenPresenter
        }
        set {
            darkSideScreenPresenter = newValue
        }
    }
    
    func set(title: String?) {
        darkSideTitle.text = title
    }
    
    func set(sithCode: CodeModel?) {
        sithCodeTitle.text = sithCode?.title
        sithCodeRules.text = sithCode?.rules
    }
    
    func set(loading isLoading: Bool) {
        switch isLoading {
        case true:
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            darkSideTitle.isHidden = true
            sithCodeTitle.isHidden = true
            sithCodeRules.isHidden = true
            sithHolocronListCollectionView.isHidden = true
            
        case false:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            darkSideTitle.isHidden = false
            sithCodeTitle.isHidden = false
            sithCodeRules.isHidden = false
            sithHolocronListCollectionView.isHidden = false
        }
    }
    
    func refreshSithHolocronList() {
        sithHolocronListCollectionView.performBatchUpdates({
            let range = Range(
                uncheckedBounds: (
                    0,
                    sithHolocronListCollectionView.numberOfSections
                )
            )
            let indexSet = IndexSet(integersIn: range)
            sithHolocronListCollectionView.reloadSections(indexSet)
        }, completion: nil)
    }
    
}

extension DarkSideScreenView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if let sithHolocronList = presenter?.sithHolocronList {
            return sithHolocronList.count
        }
        
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SithHolocronCell",
            for: indexPath)
            as? SithHolocronListCollectionViewCell
        {
            cell.nameLabel.text = nil
            cell.creatorLabel.text = nil
            cell.powersLabel.text = nil
            
            if let holocron = presenter?.sithHolocronList?[indexPath.item] {
                return updateHolocronCell(cell, holocron: holocron)
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SithHolocronListHeader",
            for: indexPath
        )
    }
    
}

extension DarkSideScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let forcedWidth: CGFloat = collectionView.bounds.size.width
        
        if var cell = SithHolocronListCollectionViewCell.loadViewFromInterfaceBuilder()
            as? SithHolocronListCollectionViewCell
        {
            cell.nameLabel.text = nil
            cell.creatorLabel.text = nil
            cell.powersLabel.text = nil
            
            if let holocron = presenter?.sithHolocronList?[indexPath.item] {
                cell = updateHolocronCell(cell, holocron: holocron)
            }
            
            let margins = cell.labelLeadingConstraint.constant
                + cell.labelTrailingConstraint.constant
            cell.nameLabel.preferredMaxLayoutWidth = forcedWidth - margins
            cell.creatorLabel.preferredMaxLayoutWidth = forcedWidth - margins
            cell.powersLabel.preferredMaxLayoutWidth = forcedWidth - margins
            let compressSize = cell.systemLayoutSizeFitting(
                UIView.layoutFittingCompressedSize
            )
            let forcedSize = CGSize(
                width: forcedWidth,
                height: compressSize.height
            )
            return forcedSize
        }
        
        return CGSize()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if let sithHolocronList = presenter?.sithHolocronList,
            sithHolocronList.count > 0
        {
            if let header = SithHolocronListHeaderView.loadViewFromInterfaceBuilder()
                as? SithHolocronListHeaderView
            {
                let compressedSize = header.systemLayoutSizeFitting(
                    UIView.layoutFittingCompressedSize
                )
                let forcedSize = CGSize(
                    width: collectionView.bounds.size.width,
                    height: compressedSize.height
                )
                
                return forcedSize
            }
        }
        
        return CGSize()
    }

}
