import UIKit

final class ProductDetailsImageCell: UITableViewCell,
                                     ProductDetailsCellConfigurable {
    static var reuseIdentifier = String(describing: ProductDetailsImageCell.self)
    
    private let productDetailsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = ColorPalette.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorPalette.appBackground
        
        addSubview(productDetailsImageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        productDetailsImageView.image = nil
    }
    
    func configure(with data: ProductDetailsCellData) {
        guard case let .image(image) = data else { return }
        productDetailsImageView.image = image
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            productDetailsImageView.widthAnchor.constraint(equalTo: widthAnchor),
            productDetailsImageView.heightAnchor.constraint(equalTo: widthAnchor),
            productDetailsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productDetailsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productDetailsImageView.topAnchor.constraint(equalTo: topAnchor),
            productDetailsImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10
            )
        ])
    }
}
