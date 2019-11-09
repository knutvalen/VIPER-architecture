import UIKit

class LightSideScreenView: UIViewController {
    private var lightSideScreenPresenter: LightSideScreenPresenterType?
    @IBOutlet weak var lightSideTitle: UILabel!
    @IBOutlet weak var jediCodeTitle: UILabel!
    @IBOutlet weak var jediCodeRules: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var jediListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "lightSideView"
        lightSideTitle.text = nil
        jediCodeTitle.text = nil
        jediCodeRules.text = nil
        activityIndicator.isHidden = true
        jediListCollectionView.register(
            UINib(
                nibName: "JediListCollectionViewCell",
                bundle: .main),
            forCellWithReuseIdentifier: "JediCell"
        )
        jediListCollectionView.register(
            UINib(
                nibName: "JediListHeaderView",
                bundle: .main),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "JediListHeader"
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Dark side",
            style: .plain,
            target: self,
            action: #selector(onDarkSideSelected)
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
    
    private func updateJediCell(
        _ jediListCollectionViewCell: JediListCollectionViewCell,
        jedi: LightSideScreenEntityType.Jedi
    ) -> JediListCollectionViewCell {
        var apprenticesText = ""
        if let apprentices = jedi.apprentices {
            for apprentice in apprentices {
                if apprenticesText.isEmpty == false {
                    apprenticesText += ", "
                }
                
                apprenticesText += [apprentice.firstName, apprentice.lastName]
                    .compactMap{ $0 }
                    .joined(separator: " ")
            }
        }
        
        if apprenticesText.isEmpty {
            apprenticesText = "<Unknown>"
        }
        
        let fullNameText = [jedi.firstName, jedi.lastName]
        .compactMap{ $0 }
        .joined(separator: " ")
        
        jediListCollectionViewCell.nameLabel.text = fullNameText
        jediListCollectionViewCell.apprenticesLabel.text = apprenticesText
        
        return jediListCollectionViewCell
    }
    
    @objc
    private func onDarkSideSelected(_ sender: UIButton) {
        presenter?.onDarkSideSelected()
    }
    
}

extension LightSideScreenView: LightSideScreenViewType {
    var presenter: LightSideScreenPresenterType? {
        get {
            return lightSideScreenPresenter
        }
        set {
            lightSideScreenPresenter = newValue
        }
    }
    
    func set(title: String?) {
        lightSideTitle.text = title
    }
    
    func set(jediCode: CodeModel?) {
        jediCodeTitle.text = jediCode?.title
        jediCodeRules.text = jediCode?.rules
    }
    
    func set(loading isLoading: Bool) {
        switch isLoading {
        case true:
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            lightSideTitle.isHidden = true
            jediCodeTitle.isHidden = true
            jediCodeRules.isHidden = true
            jediListCollectionView.isHidden = true
            
        case false:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            lightSideTitle.isHidden = false
            jediCodeTitle.isHidden = false
            jediCodeRules.isHidden = false
            jediListCollectionView.isHidden = false
        }
    }
    
    func refreshJediList() {
        jediListCollectionView.performBatchUpdates({
            let range = Range(
                uncheckedBounds: (
                    0,
                    jediListCollectionView.numberOfSections
                )
            )
            let indexSet = IndexSet(integersIn: range)
            jediListCollectionView.reloadSections(indexSet)
        }, completion: nil)
    }
    
}

extension LightSideScreenView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if let jediList = presenter?.jediList {
            return jediList.count
        }
        
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "JediCell",
            for: indexPath)
            as? JediListCollectionViewCell
        {
            cell.nameLabel.text = nil
            cell.apprenticesLabel.text = nil
            
            if let jedi = presenter?.jediList?[indexPath.item] {
                return updateJediCell(cell, jedi: jedi)
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
            withReuseIdentifier: "JediListHeader",
            for: indexPath
        )
    }
    
}

extension LightSideScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let forcedWidth: CGFloat = (collectionView.bounds.size.width) / 2 - 8
        
        if var cell = JediListCollectionViewCell.loadViewFromInterfaceBuilder()
            as? JediListCollectionViewCell
        {
            cell.nameLabel.text = nil
            cell.apprenticesLabel.text = nil
            
            if let jedi = presenter?.jediList?[indexPath.item] {
                cell = updateJediCell(cell, jedi: jedi)
            }
            
            let margins = cell.subtitleLabelLeadingConstraint.constant
                + cell.subtitleLabelTrailingConstraint.constant
            cell.nameLabel.preferredMaxLayoutWidth = forcedWidth - margins
            cell.apprenticesLabel.preferredMaxLayoutWidth = forcedWidth - margins
            let compressedSize = cell.systemLayoutSizeFitting(
                UIView.layoutFittingCompressedSize
            )
            let forcedSize = CGSize(
                width: forcedWidth,
                height: compressedSize.height
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
        if let jediList = presenter?.jediList,
            jediList.count > 0
        {
            if let header = JediListHeaderView.loadViewFromInterfaceBuilder()
                as? JediListHeaderView
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
