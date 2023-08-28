import UIKit

final class ProductDetailsViewController: UIViewController {
    private enum ProductDetailsState {
        case loading
        case presenting(ProductDetails)
        case failed(NetworkError)
    }
    
    private let productDetailsView = ProductDetailsView()
    
    private let errorDisplayer: ErrorDisplayable
    private let loadingDisplayer: LoadingDisplayable
    
    private let productId: Int
    private let networkManager: NetworkManager
    
    init(
        productId: Int,
        networkManager: NetworkManager = DefaultNetworkManager(),
        errorDisplayer: ErrorDisplayable = ErrorDisplayer(),
        loadingDisplayer: LoadingDisplayable = LoadingDisplayer()
    ) {
        self.productId = productId
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
        navigationController?.navigationBar.prefersLargeTitles = false
        
        getProductDetails()
    }
    
    private func getProductDetails() {
        render(.loading)
        networkManager.getProductDetails(by: productId) { result in
            switch result {
            case let .success(productDetails):
                self.render(.presenting(productDetails))
            case let .failure(error):
                self.render(.failed(error))
            }
        }
    }
    
    private func render(_ state: ProductDetailsState) {
        switch state {
        case .loading:
            loadingDisplayer.showLoading(in: self)
        case let .presenting(productDetails):
            loadingDisplayer.hideLoading()
            
            setUpProductDetailsView()
            productDetailsView.display(productDetails)
        case let .failed(error):
            loadingDisplayer.hideLoading()
            
            errorDisplayer.presentAlert(with: error, in: self) { [weak self] in
                guard let self else { return }
                self.getProductDetails()
            }
        }
    }
    
    private func setUpProductDetailsView() {
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productDetailsView)
        NSLayoutConstraint.activate([
            productDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            productDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
