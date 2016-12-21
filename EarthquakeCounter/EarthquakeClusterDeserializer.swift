import Foundation
import PromiseKit

struct EarthquakeDeserializationError: Error {
    var description: String
}

protocol EarthquakeClusterDeserializer {
    func deserialize(_ representation: NSDictionary) -> EarthquakeClusterPromise
}

class RealEarthquakeClusterDeserializer: EarthquakeClusterDeserializer {
    func deserialize(_ representation: NSDictionary) -> EarthquakeClusterPromise {
        let promise = EarthquakeClusterPromise { fulfill, reject in

            guard let features = representation["features"] as? [NSDictionary]
                else {
                    let error = EarthquakeDeserializationError(description: "JSON response does not contain list of features: \(representation)")
                    reject(error)
                    return
            }

            let cluster =  features.flatMap { return try? self.deserializeEarthquake($0) }
            fulfill(cluster)
        }
        return promise


    }

    fileprivate func deserializeEarthquake(_ representation: NSDictionary) throws -> Earthquake {
        guard let properties = representation["properties"] as? [String: AnyObject],
            let place = properties["place"] as? String,
            let magnitude = properties["mag"] as? Double,
            let dateAsMillseconds = properties["time"] as? Int else {
            throw EarthquakeDeserializationError(description: "Representation does not contain place, magnitude, dateAsMilliseconds \(representation)")
        }

        let date = Date(timeIntervalSince1970: TimeInterval(dateAsMillseconds / 1000))
        return Earthquake(date: date, magnitude: magnitude, place: place)

    }
}
