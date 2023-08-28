import UIKit

final class ProductDetailsContactCell: UITableViewCell,
                                       ProductDetailsCellConfigurable {
    static var reuseIdentifier = String(describing: ProductDetailsContactCell.self)
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorPalette.text
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "copy"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(
            self,
            action: #selector(didTapCopyButton),
            for: .touchUpInside
        )
        button.backgroundColor = ColorPalette.appBackground
        button.tintColor = ColorPalette.text
        button.layer.cornerRadius = Constants.buttonCornerRadius
        return button
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorPalette.appBackground
        contentView.isUserInteractionEnabled = true
        
        addSubview(copyButton)
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
        guard case let .contact(text) = data else { return }
        label.text = text
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            copyButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.horizontalOffset
            ),
            copyButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Constants.verticalOffset
            ),
            copyButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Constants.verticalOffset
            ),
            copyButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            copyButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.horizontalOffset
            ),
            label.trailingAnchor.constraint(
                equalTo: copyButton.leadingAnchor,
                constant: -Constants.horizontalOffset
            ),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc
    private func didTapCopyButton(_ sender: Any) {
        guard let text = label.text else { return }
        UIPasteboard.general.string = text
    }
}

private enum Constants {
    static let labelFontSize: CGFloat = 20
    static let buttonCornerRadius: CGFloat = 10
    
    static let horizontalOffset: CGFloat = 15
    static let verticalOffset: CGFloat = 10
    
    static let buttonSize: CGFloat = 40
}
