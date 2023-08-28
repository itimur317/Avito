import UIKit

struct ProductDetails {
    let id: Int
    let title: String
    let price: String
    let location: String
    let image: UIImage?
    let date: Date
    let description: String
    let email: String
    let phoneNumber: String
    let address: String 
}

extension ProductDetails {
    func copy(with image: UIImage) -> ProductDetails {
        ProductDetails(
            id: self.id,
            title: self.title,
            price: self.price,
            location: self.location,
            image: image,
            date: self.date,
            description: self.description,
            email: self.email,
            phoneNumber: self.phoneNumber,
            address: self.address
        )
    }
}

extension ProductDetails: Equatable {
    static func == (
        lhs: ProductDetails,
        rhs: ProductDetails
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.location == rhs.location &&
        lhs.image == rhs.image &&
        lhs.date == rhs.date &&
        lhs.description == rhs.description &&
        lhs.email == rhs.email &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.address == rhs.address
    }
}
