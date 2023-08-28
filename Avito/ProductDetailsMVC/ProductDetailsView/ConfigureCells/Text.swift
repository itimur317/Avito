import UIKit

struct Text {
    let title: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let color: UIColor
    
    init(
        title: String,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight = .regular,
        color: UIColor = ColorPalette.text
    ) {
        self.title = title
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.color = color
    }
}
