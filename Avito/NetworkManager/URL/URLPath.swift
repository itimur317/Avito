import Foundation

enum URLPath {
    case list
    case details(id: Int)
    
    var rawValue: String {
        switch self {
        case .list:
            return "/s/interns-ios/main-page.json"
        case let .details(id):
            return "/s/interns-ios/details/\(id).json"
        }
    }
}
