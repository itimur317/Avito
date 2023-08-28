import Foundation

typealias ProductListDTOResult = Result<ProductListDTO, NetworkError>

protocol ProductListLoadable: AnyObject {
    func getProductListDTO(completion: @escaping (ProductListDTOResult) -> Void)
}
