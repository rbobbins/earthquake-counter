import Foundation
import PromiseKit

struct EarthquakeDeserializationError: ErrorType {
    var description: String
}

public protocol EarthquakeClusterDeserializer {
    func deserialize(representation: NSDictionary) -> EarthquakeClusterPromise
}

class RealEarthquakeClusterDeserializer: EarthquakeClusterDeserializer {
    func deserialize(representation: NSDictionary) -> EarthquakeClusterPromise {
        let promise = EarthquakeClusterPromise { fulfill, reject in

            guard let features = representation["features"] as? [[String: AnyObject]]
                else {
                    let error = EarthquakeDeserializationError(description: "JSON response does not contain list of features: \(representation)")
                    reject(error)
                    return
            }

            do {
                let cluster = try features.map { return try self.deserializeEarthquake($0) }
                fulfill(cluster)
            } catch let error {
                reject(error)
            }
        }
        return promise


    }

    private func deserializeEarthquake(representation: NSDictionary) throws -> Earthquake {
        guard let properties = representation["properties"] as? [String: AnyObject],
            place = properties["place"] as? String,
            magnitude = properties["mag"] as? Double,
            dateAsMillseconds = properties["time"] as? Int else {
            throw EarthquakeDeserializationError(description: "Representation does not contain place, magnitude, dateAsMilliseconds \(representation)")
        }

        let date = NSDate(timeIntervalSince1970: NSTimeInterval(dateAsMillseconds / 1000))
        return Earthquake(date: date, magnitude: magnitude, place: place)

    }
}
