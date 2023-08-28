import UIKit

protocol ProductListViewDelegate:AnyObject {
    func didSelect(_ model: ProductListModel)
}

final class ProductListView: UIView,
                             UICollectionViewDataSource,
                             UICollectionViewDelegate,
                             UICollectionViewDelegateFlowLayout {
    weak var delegate: ProductListViewDelegate?
    
    private var models: [ProductListModel] = []
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Constants.inset,
            bottom: Constants.inset,
            right: Constants.inset
        )
        layout.minimumLineSpacing = Constants.inset
        layout.minimumInteritemSpacing = Constants.inset
        return layout
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        
        collectionView.backgroundColor = .yellow
        collectionView.register(
            ProductListViewCell.self,
            forCellWithReuseIdentifier: ProductListViewCell.reuseIdentifier
        )
        collectionView.backgroundColor = ColorPalette.appBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var collectionViewCellWidth: CGFloat {
        (listCollectionView.bounds.width - Constants.inset * 3) / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorPalette.appBackground
        
        addSubview(listCollectionView)
        setUpConstraints()
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(models: [ProductListModel]) {
        if self.models == models { return }
        
        self.models = models
        listCollectionView.reloadData()
    }
    
    private func setUpContent() {
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            listCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listCollectionView.topAnchor.constraint(equalTo: topAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductListView {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionViewCellWidth
        let height = width + Constants.descriptionCellHeight

        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate
extension ProductListView {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let index = indexPath.section * Constants.numberOfItemsInSection + indexPath.row
        delegate?.didSelect(models[index])
    }
}

// MARK: - UICollectionViewDataSource
extension ProductListView {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        (models.count + 1) / 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        Constants.numberOfItemsInSection
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductListViewCell.reuseIdentifier,
            for: indexPath
        ) as? ProductListViewCell else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.section * Constants.numberOfItemsInSection + indexPath.row
        cell.configure(
            model: models[index],
            width: collectionViewCellWidth
        )
        return cell
    }
}

private enum Constants {
    static var inset: CGFloat = 10
    static var descriptionCellHeight: CGFloat = 85
    static var numberOfItemsInSection = 2
}
