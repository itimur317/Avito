import UIKit

struct ProductListDTO: Codable {
    let productListModels: [ProductListModelDTO]
    
    enum CodingKeys: String, CodingKey {
        case productListModels = "advertisements"
    }
}

extension ProductListDTO {
    var toProductListModels: [ProductListModel] {
        productListModels.compactMap { ProductListModel(from: $0) }
    }
}
