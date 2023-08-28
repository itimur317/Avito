import Foundation

final class DependencyContainer {
    private lazy var networkManager: NetworkManager = DefaultNetworkManager(
        imageLoader: imageLoader,
        productListLoader: productListLoader,
        productDetailsLoader: productDetailsLoader
    )
    
    private lazy var errorDisplayer: ErrorDisplayable = ErrorDisplayer()
    private lazy var loadingDisplayer: LoadingDisplayable = LoadingDisplayer()
    
    private lazy var imageLoader: ImageLoadable = ImageLoader()
    private lazy var productListLoader: ProductListLoadable = ProductListLoader()
    private lazy var productDetailsLoader: ProductDetailsLoadable = ProductDetailsLoader()
}

extension DependencyContainer {
    func makeProductListViewController() -> ProductListViewController {
        ProductListViewController(
            networkManager: networkManager,
            errorDisplayer: errorDisplayer,
            loadingDisplayer: loadingDisplayer
        )
    }
}
