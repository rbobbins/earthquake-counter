import EarthquakeCounter

class FakeEarthquakeService: EarthquakeService {
    //MARK: Track methods that were called
    var getSanRamonEarthquakes_wasCalled = false

    //MARK: EarthquakeService
    func getSanRamonEarthquakes() {
        getSanRamonEarthquakes_wasCalled = true
    }

    //MARK: Helper methods for fake
    func reset() {
        getSanRamonEarthquakes_wasCalled = false
    }
}