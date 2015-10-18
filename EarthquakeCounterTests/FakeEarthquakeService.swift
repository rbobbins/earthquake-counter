import EarthquakeCounter
import PromiseKit

class FakeEarthquakeService: EarthquakeService {
    //MARK: Track methods that were called
    var getSanRamonEarthquakes_wasCalled = false

    //MARK: EarthquakeService
    func getSanRamonEarthquakes() -> Promise<Void> {
        getSanRamonEarthquakes_wasCalled = true
        return Promise<Void>.pendingPromise().promise
    }

    //MARK: Helper methods for fake
    func reset() {
        getSanRamonEarthquakes_wasCalled = false
    }
}