public protocol EarthquakeService {
    func getSanRamonEarthquakes()
}

class RealEarthquakeService: EarthquakeService {
    func getSanRamonEarthquakes() {
        //no-op, for now
    }
}