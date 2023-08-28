import Foundation

protocol ProductDetailsCellConfigurable {
    static var reuseIdentifier: String { get }
    
    func configure(with data: ProductDetailsCellData)
}
