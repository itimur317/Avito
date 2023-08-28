import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: self)) ?? 0
        
        dateFormatter.dateFormat = "dd"
        let date = dateFormatter.string(from: self)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: self)
        
        return "\(date) \(month.monthName) \(year)"
    }
}
