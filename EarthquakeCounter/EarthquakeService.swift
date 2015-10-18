import Foundation

public protocol EarthquakeService {
    func getSanRamonEarthquakes()
}

class RealEarthquakeService: EarthquakeService {
    let httpClient: HTTPClient

    init(httpClient: HTTPClient = RealHTTPClient()) {
        self.httpClient = httpClient
    }

    func getSanRamonEarthquakes() {
        let url = "http://earthquake.usgs.gov/fdsnws/event/1/count?format=geojson&latitude=37.7800&longitude=-121.9871&maxradiuskm=5&starttime=2015-10-01"

        httpClient.get(url)
    }
}