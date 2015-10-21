import Foundation
@testable import EarthquakeCounter

class FakeEarthquakeClusterDeserializer: EarthquakeClusterDeserializer {
    var deserialize_wasCalled = false
    var deserialize_wasCalled_withRepresentation: NSDictionary? = nil

    var succeedAtDeserializing: (EarthquakeCluster -> Void)?
    var failAtDeserializing: (NSError -> Void)?

    init() {}
    
    func deserialize(representation: NSDictionary) -> EarthquakeClusterPromise {
        deserialize_wasCalled = true
        deserialize_wasCalled_withRepresentation = representation
        
        let deferred = EarthquakeClusterPromise.pendingPromise()
        succeedAtDeserializing = deferred.fulfill
        failAtDeserializing = { deferred.reject($0) }
        return deferred.promise
    }
}