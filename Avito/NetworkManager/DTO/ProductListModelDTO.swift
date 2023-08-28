import Foundation

struct ProductListModelDTO: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case location
        case imageUrl = "image_url"
        case date = "created_date"
    }
}

extension ProductListModel {
    init?(from dto: ProductListModelDTO) {
        guard let date = dto.date.toDate,
              let id = Int(dto.id) else {
            return nil
        }
        
        self.id = id
        self.title = dto.title
        self.price = dto.price
        self.location = dto.location
        self.date = date
        self.image = nil
    }
}
