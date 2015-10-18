import Foundation
import PromiseKit

public protocol EarthquakeService {
    func getSanRamonEarthquakes() -> Promise<Void>
}

class RealEarthquakeService: EarthquakeService {
    let httpClient: HTTPClient
    let deserializer: EarthquakeClusterDeserializer

    init(httpClient: HTTPClient = RealHTTPClient(), deserializer: EarthquakeClusterDeserializer = RealEarthquakeClusterDeserializer()) {
        self.httpClient = httpClient
        self.deserializer = deserializer
    }

    func getSanRamonEarthquakes() -> Promise<Void> {
        let url = "http://earthquake.usgs.gov/fdsnws/event/1/count?format=geojson&latitude=37.7800&longitude=-121.9871&maxradiuskm=5&starttime=2015-10-01"

        return httpClient.get(url).then { _ -> Void in }
    }
}