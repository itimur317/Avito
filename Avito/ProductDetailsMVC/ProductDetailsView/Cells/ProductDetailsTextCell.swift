import UIKit

final class ProductDetailsTextCell: UITableViewCell,
                                    ProductDetailsCellConfigurable {
    static var reuseIdentifier = String(describing: ProductDetailsTextCell.self)
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = ColorPalette.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorPalette.appBackground
        
        addSubview(label)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    func configure(with data: ProductDetailsCellData) {
        guard case let .text(text) = data else { return }
        label.text = text.title
        label.textColor = text.color
        label.font = UIFont.systemFont(
            ofSize: text.fontSize,
            weight: text.fontWeight
        )
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.leadingOffset
            ),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.topOffset
            ),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}

private enum Constants {
    static let leadingOffset: CGFloat = 15
    static let topOffset: CGFloat = 5
}
