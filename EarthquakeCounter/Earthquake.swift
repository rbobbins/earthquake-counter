import Foundation

typealias EarthquakeCluster = [Earthquake]
struct Earthquake {
    var date: NSDate
    var magnitude: Double
    var place: String
}

extension Earthquake: Equatable {}

func ==(lhs: Earthquake, rhs: Earthquake) -> Bool {
    return lhs.date.isEqualToDate(rhs.date) &&
        lhs.magnitude == rhs.magnitude &&
        lhs.place == rhs.place
}