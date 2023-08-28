import UIKit

typealias UIImageResult = Result<UIImage, NetworkError>

protocol ImageLoadable: AnyObject {
    func loadImage(by url: URL, completion: @escaping (UIImageResult) -> Void)
}
