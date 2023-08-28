import Foundation

protocol HTTPRequest {
    func execute<T: Decodable>(
        url: URL,
        requestType: HTTPMethod,
        callback: @escaping (Result<T, NetworkError>) -> Void
    )
    
    func execute(
        url: URL,
        requestType: HTTPMethod,
        callback: @escaping (Result<Data, NetworkError>) -> Void
    )
}

struct DefaultHTTPRequest: HTTPRequest {
    let session: URLSession
    
    init(session: URLSession = .defaultSession()) {
        self.session = session
    }
    
    func execute<T: Decodable>(
        url: URL,
        requestType: HTTPMethod,
        callback: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                callback(.failure(NetworkError.notNet))
                return
            }
            
            let handledResult = HTTPNetworkResponse.handleNetworkResponse(for: response)
            
            guard let unwrappedData = data else {
                callback(.failure(NetworkError.emptyDataError))
                return
            }
            
            switch handledResult {
            case .success:
                guard let result = try? JSONDecoder().decode(
                    T.self,
                    from: unwrappedData
                ) else {
                    callback(.failure(NetworkError.parsingError))
                    return
                }
                callback(.success(result))
            case let .failure(error):
                callback(.failure(error))
            }
        }
        task.resume()
    }
    
    func execute(
        url: URL,
        requestType: HTTPMethod,
        callback: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                callback(.failure(NetworkError.notNet))
                return
            }
            
            let handledResult = HTTPNetworkResponse.handleNetworkResponse(for: response)
            
            guard let unwrappedData = data else {
                callback(.failure(NetworkError.emptyDataError))
                return
            }
            
            switch handledResult {
            case .success:
                callback(.success(unwrappedData))
            case let .failure(error):
                callback(.failure(error))
            }
        }
        task.resume()
    }
}

extension URLSession {
    static func defaultSession() -> URLSession {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = TimeInterval(7)
        return session
    }
}
