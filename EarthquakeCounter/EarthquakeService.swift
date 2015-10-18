public protocol EarthquakeService {
    func getSanRamonEarthquakes()
}

class RealEarthquakeService: EarthquakeService {
    let httpClient: HTTPClient

    init(httpClient: HTTPClient = RealHTTPClient()) {
        self.httpClient = httpClient
    }

    func getSanRamonEarthquakes() {
        //no-op, for now
    }
}