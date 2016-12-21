import EarthquakeCounter
import PromiseKit
@testable import EarthquakeCounter

class FakeEarthquakeService: EarthquakeService {
    //MARK: Track methods that were called
    var getSanRamonEarthquakes_wasCalled = false

    //MARK: Stub methods
    var stub_getSanRamonEarthquakes: EarthquakeClusterPromise = EarthquakeClusterPromise.pending().promise

    //MARK: EarthquakeService
    func getSanRamonEarthquakes() -> EarthquakeClusterPromise {
        getSanRamonEarthquakes_wasCalled = true
        return stub_getSanRamonEarthquakes
    }
}
