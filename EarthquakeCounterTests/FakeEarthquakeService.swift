import EarthquakeCounter

class FakeEarthquakeService: EarthquakeService {
    var getSanRamonEarthquakes_wasCalled = false

    func getSanRamonEarthquakes() {
        getSanRamonEarthquakes_wasCalled = true
    }
}