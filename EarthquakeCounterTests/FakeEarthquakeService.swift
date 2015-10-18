import EarthquakeCounter
import PromiseKit

class FakeEarthquakeService: EarthquakeService {
    //MARK: Track methods that were called
    var getSanRamonEarthquakes_wasCalled = false

    //MARK: EarthquakeService
    func getSanRamonEarthquakes() -> EarthquakeClusterPromise {
        getSanRamonEarthquakes_wasCalled = true
        return EarthquakeClusterPromise.pendingPromise().promise
    }

    //MARK: Helper methods for fake
    func reset() {
        getSanRamonEarthquakes_wasCalled = false
    }
}