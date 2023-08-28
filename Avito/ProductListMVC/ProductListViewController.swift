import UIKit

final class ProductListViewController: UIViewController {
    private enum ProductListState {
        case loading
        case presenting([ProductListModel])
        case failed(NetworkError)
    }
    
    private let productListView = ProductListView()
    
    private let errorDisplayer: ErrorDisplayable
    private let loadingDisplayer: LoadingDisplayable
    
    private let networkManager: NetworkManager
    
    init(
        networkManager: NetworkManager = DefaultNetworkManager(),
        errorDisplayer: ErrorDisplayable = ErrorDisplayer(),
        loadingDisplayer: LoadingDisplayable = LoadingDisplayer()
    ) {
        self.networkManager = networkManager
        self.errorDisplayer = errorDisplayer
        self.loadingDisplayer = loadingDisplayer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.appBackground
        
        title = "Товары"
        navigationController?.navigationBar.prefersLargeTitles = true
        productListView.delegate = self
        
        getProductList()
    }
    
    private func getProductList() {
        render(.loading)
        networkManager.getProductList { result in
            switch result {
            case let .success(models):
                self.render(.presenting(models))
            case let .failure(error):
                self.render(.failed(error))
            }
        }
    }
    
    private func render(_ state: ProductListState) {
        switch state {
        case .loading:
            loadingDisplayer.showLoading(in: self)
        case let .presenting(productListModels):
            loadingDisplayer.hideLoading()
            setUpProductListView()
            productListView.display(models: productListModels)
        case let .failed(error):
            loadingDisplayer.hideLoading()
            errorDisplayer.presentAlert(with: error, in: self) { [weak self] in
                guard let self else { return }
                self.getProductList()
            }
        }
    }
    
    private func setUpProductListView() {
        productListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productListView)
        NSLayoutConstraint.activate([
            productListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListView.topAnchor.constraint(equalTo: view.topAnchor),
            productListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductListViewController: ProductListViewDelegate {
    func didSelect(_ model: ProductListModel) {
        let productDetailsViewController = ProductDetailsViewController(
            productId: model.id
        )
        navigationController?.pushViewController(
            productDetailsViewController,
            animated: true
        )
    }
}
