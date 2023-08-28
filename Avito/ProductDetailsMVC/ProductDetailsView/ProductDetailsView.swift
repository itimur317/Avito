import UIKit

final class ProductDetailsView: UIView,
                                UITableViewDataSource {
    private var productDetails: ProductDetails?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorPalette.appBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(
            ProductDetailsImageCell.self,
            forCellReuseIdentifier: ProductDetailsImageCell.reuseIdentifier
        )
        tableView.register(
            ProductDetailsTextCell.self,
            forCellReuseIdentifier: ProductDetailsTextCell.reuseIdentifier
        )
        tableView.register(
            ProductDetailsContactCell.self,
            forCellReuseIdentifier: ProductDetailsContactCell.reuseIdentifier
        )
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var cellsData: [ProductDetailsCellData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorPalette.appBackground
        
        addSubview(tableView)
        setUpConstraints()
        setUpContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(_ productDetails: ProductDetails) {
        if self.productDetails == productDetails { return }
        self.productDetails = productDetails
        
        cellsData = [
            .image(productDetails.image),
            .text(
                Text(
                    title: productDetails.title,
                    fontSize: 25
                )
            ),
            .text(
                Text(
                    title: productDetails.price,
                    fontSize: 22,
                    fontWeight: .bold
                )
            ),
            .text(
                Text(
                    title: "\(productDetails.location), \(productDetails.address)",
                    fontSize: 18
                )
            ),
            .text(
                Text(
                    title: productDetails.date.toString,
                    fontSize: 18,
                    color: .systemGray
                )
            ),
            .contact(productDetails.phoneNumber),
            .contact(productDetails.email),
            .text(
                Text(
                    title: productDetails.description,
                    fontSize: 16
                )
            ),
        ]
        tableView.reloadData()
    }
    
    private func setUpContent() {
        tableView.dataSource = self
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ProductDetailsView {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        cellsData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellsData[indexPath.row].reuseIdentifier,
            for: indexPath
        ) as? (UITableViewCell & ProductDetailsCellConfigurable) else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
        
        cell.configure(with: cellsData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
