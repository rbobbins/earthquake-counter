import Foundation
import PromiseKit

public typealias EarthquakeClusterPromise = Promise<EarthquakeCluster>
public protocol EarthquakeClusterDeserializer {
    func deserialize(representation: NSDictionary) -> EarthquakeClusterPromise
}

class RealEarthquakeClusterDeserializer: EarthquakeClusterDeserializer {
    func deserialize(representation: NSDictionary) -> EarthquakeClusterPromise {
        //no-op for now
        return EarthquakeClusterPromise.pendingPromise().promise
    }
}
