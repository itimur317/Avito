import Foundation

final class ProductDetailsLoader: ProductDetailsLoadable {
    private let request: HTTPRequest
    
    private let completionQueue: DispatchQueue
    private let backgroundQueue: DispatchQueue
    
    init(
        request: HTTPRequest = DefaultHTTPRequest(),
        completionQueue: DispatchQueue = DispatchQueue.main,
        backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)
    ) {
        self.request = request
        self.completionQueue = completionQueue
        self.backgroundQueue = backgroundQueue
    }
    
    func getProductDetailsDTO(
        by id: Int,
        completion: @escaping (ProductDetailsDTOResult) -> Void
    ) {
        backgroundQueue.async { [weak self] in
            guard let self else { return }
            
            let urlData = URLData(
                urlProtocol: .https,
                urlHost: .host,
                urlPath: .details(id: id)
            )
            
            self.request.execute(
                url: urlData.url,
                requestType: .get
            ) { (result: ProductDetailsDTOResult) in
                self.completionQueue.async {
                    switch result {
                    case let .success(dto):
                        completion(.success(dto))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
