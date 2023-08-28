import UIKit

struct ProductListModel {
    let id: Int
    let title: String
    let price: String
    let location: String
    let image: UIImage?
    let date: Date
}

extension ProductListModel: Equatable {
    static func == (
        lhs: ProductListModel,
        rhs: ProductListModel
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.location == rhs.location &&
        lhs.image == rhs.image &&
        lhs.date == rhs.date
    }
    
    func copy(with image: UIImage) -> ProductListModel {
        ProductListModel(
            id: self.id,
            title: self.title,
            price: self.price,
            location: self.location,
            image: image,
            date: self.date
        )
    }
}
