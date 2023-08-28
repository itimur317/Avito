import Foundation

extension Int {
    var monthName: String {
        let months = [
            "янв",
            "фев",
            "мар",
            "апр",
            "май",
            "июн",
            "июл",
            "авг",
            "сен",
            "окт",
            "ноя",
            "дек"
        ]
        return months[self - 1]
    }
}
