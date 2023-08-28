import UIKit

enum ProductDetailsCellData {
    case image(UIImage?)
    case text(Text)
    case contact(String)
}

extension ProductDetailsCellData {
    var reuseIdentifier: String {
        switch self {
        case .image:
            return ProductDetailsImageCell.reuseIdentifier
        case .text:
            return ProductDetailsTextCell.reuseIdentifier
        case .contact:
            return ProductDetailsContactCell.reuseIdentifier
        }
    }
}
