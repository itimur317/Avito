import UIKit

final class ProductListViewCell: UICollectionViewCell {
    static var reuseIdentifier = String(describing: ProductListViewCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = ColorPalette.gray
        
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .body),
            size: Constants.titlePriceFontSize
        )
        label.numberOfLines = 1
        label.textColor = ColorPalette.text
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .headline),
            size: Constants.titlePriceFontSize
        )
        label.textColor = ColorPalette.text
        label.textAlignment = .left
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .callout),
            size: Constants.locationAndDateFontSize
        )
        label.textColor = ColorPalette.gray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            descriptor: .preferredFontDescriptor(withTextStyle: .callout),
            size: Constants.locationAndDateFontSize
        )
        label.textColor = ColorPalette.gray
        label.textAlignment = .left
        return label
    }()
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
        
        deactivateConstraints()
    }
    
    func configure(model: ProductListModel, width: CGFloat) {
        imageView.image = model.image
        titleLabel.text = model.title
        priceLabel.text = model.price
        locationLabel.text = model.location
        dateLabel.text = model.date.toString
        
        [imageView, titleLabel, priceLabel, locationLabel, dateLabel]
            .forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)
            }
        
        backgroundColor = ColorPalette.appBackground
        activateConstraints(with: width)
    }
    
    private func activateConstraints(with width: CGFloat) {
        getConstraints(width: width).forEach {
            $0.isActive = true
        }
    }
    
    private func deactivateConstraints() {
        getConstraints(width: .zero).forEach {
            $0.isActive = false
        }
    }
    
    private func getConstraints(width: CGFloat) -> [NSLayoutConstraint] {[
        imageView.topAnchor.constraint(equalTo: topAnchor),
        imageView.widthAnchor.constraint(equalToConstant: width),
        imageView.heightAnchor.constraint(equalTo: widthAnchor),
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        
        priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        priceLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        
        locationLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        locationLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
        
        dateLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        dateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]}
}

private enum Constants {
    static let imageCornerRadius: CGFloat = 10
    
    static let titlePriceFontSize: CGFloat = 18
    static let locationAndDateFontSize: CGFloat = 16
}
