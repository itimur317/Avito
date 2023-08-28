import Foundation

final class ProductListLoader: ProductListLoadable {
    private var urlData: URLData
    private let request: HTTPRequest
    
    private let completionQueue: DispatchQueue
    private let backgroundQueue: DispatchQueue
    
    init(
        urlData: URLData = URLData(
            urlProtocol: .https,
            urlHost: .host,
            urlPath: .list
        ),
        request: HTTPRequest = DefaultHTTPRequest(),
        completionQueue: DispatchQueue = DispatchQueue.main,
        backgroundQueue: DispatchQueue = DispatchQueue.global(qos: .background)
    ) {
        self.urlData = urlData
        self.request = request
        self.completionQueue = completionQueue
        self.backgroundQueue = backgroundQueue
    }
    
    func getProductListDTO(completion: @escaping (ProductListDTOResult) -> Void) {
        backgroundQueue.async { [weak self] in
            guard let self else { return }
            
            self.request.execute(
                url: self.urlData.url,
                requestType: .get
            ) { (result: ProductListDTOResult) in
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
