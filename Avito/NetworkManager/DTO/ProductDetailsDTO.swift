import Foundation

struct ProductDetailsDTO: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let date: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageUrl = "image_url"
        case date = "created_date"
        case description
        case email
        case phoneNumber = "phone_number"
        case address
    }
}

extension ProductDetails {
    init?(from dto: ProductDetailsDTO) {
        guard let id = Int(dto.id),
              let date = dto.date.toDate else {
            return nil
        }
        
        self.id  = id
        self.title = dto.title
        self.price = dto.price
        self.location = dto.location
        self.image = nil
        self.date = date
        self.description = dto.description
        self.email = dto.email
        self.phoneNumber = dto.phoneNumber
        self.address = dto.address
    }
}
