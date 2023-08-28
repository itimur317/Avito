import UIKit

typealias ProductListResult = Result<[ProductListModel], NetworkError>
typealias ProductDetailsResult = Result<ProductDetails, NetworkError>

protocol NetworkManager: AnyObject {
    func getProductList(
        completion: @escaping (ProductListResult) -> Void
    )
    
    func getProductDetails(
        by id: Int,
        completion: @escaping (ProductDetailsResult) -> Void
    )
}

final class DefaultNetworkManager: NetworkManager {
    private let imageLoader: ImageLoadable
    private let productListLoader: ProductListLoadable
    private let productDetailsLoader: ProductDetailsLoadable
    
    private let completionQueue: DispatchQueue
    private let backgroundQueue: DispatchQueue
    
    init(
        imageLoader: ImageLoadable = ImageLoader(),
        productListLoader: ProductListLoadable = ProductListLoader(),
        productDetailsLoader: ProductDetailsLoadable = ProductDetailsLoader(),
        completionQueue: DispatchQueue = DispatchQueue.main,
        backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)
    ) {
        self.imageLoader = imageLoader
        self.productListLoader = productListLoader
        self.productDetailsLoader = productDetailsLoader
        self.completionQueue = completionQueue
        self.backgroundQueue = backgroundQueue
    }
    
    func getProductList(completion: @escaping (ProductListResult) -> Void) {
        productListLoader.getProductListDTO { productListDTOResult in
            switch productListDTOResult {
            case let .success(dto):
                var models = dto.toProductListModels
                guard models.count == dto.productListModels.count else {
                    completion(.failure(.failed))
                    return
                }
                completion(.success(models))
                
                // MARK: - ImageLoading
                for (index, productListModelDTO) in dto.productListModels.enumerated() {
                    guard let url = URL(string: productListModelDTO.imageUrl) else { return }
                    
                    self.imageLoader.loadImage(by: url) { imageResult in
                        guard case let .success(image) = imageResult else { return }
                        models[index] = models[index].copy(with: image)
                        completion(.success(models))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getProductDetails(by id: Int, completion: @escaping (ProductDetailsResult) -> Void) {
        productDetailsLoader.getProductDetailsDTO(by: id) { productDetailsDTOResult in
            switch productDetailsDTOResult {
            case let .success(dto):
                guard let productDetails = ProductDetails(from: dto) else {
                    completion(.failure(NetworkError.parsingError))
                    return
                }
                completion(.success(productDetails))
                
                // MARK: - ImageLoading
                guard let url = URL(string: dto.imageUrl) else { return }
                self.imageLoader.loadImage(by: url) { imageResult in
                    guard case let .success(image) = imageResult else { return }
                    let productDetailsWithImage = productDetails.copy(with: image)
                    completion(.success(productDetailsWithImage))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
