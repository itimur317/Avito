import Foundation

typealias ProductDetailsDTOResult = Result<ProductDetailsDTO, NetworkError>

protocol ProductDetailsLoadable: AnyObject {
    func getProductDetailsDTO(
        by id: Int,
        completion: @escaping (ProductDetailsDTOResult) -> Void
    )
}
