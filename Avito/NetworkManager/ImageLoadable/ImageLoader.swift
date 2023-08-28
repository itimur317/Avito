import UIKit

typealias DataResult = Result<Data, NetworkError>

final class ImageLoader: ImageLoadable {
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
    
    func loadImage(by url: URL, completion: @escaping (UIImageResult) -> Void) {
        backgroundQueue.async { [weak self] in
            guard let self else { return }
            
            self.request.execute(
                url: url,
                requestType: .get
            ) { (result: DataResult) in
                self.completionQueue.async {
                    switch result {
                    case let .success(data):
                        guard let image = UIImage(data: data) else {
                            completion(.failure(.parsingError))
                            return
                        }
                        completion(.success(image))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
