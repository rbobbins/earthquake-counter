import Foundation

public typealias EarthquakeCluster = [Earthquake]
public struct Earthquake {
    var date: NSDate
    var magnitude: Double
    var place: String
}