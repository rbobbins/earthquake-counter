import Quick
import Nimble
import PromiseKit
@testable import EarthquakeCounter

class EarthquakeServiceSpec: QuickSpec {
    override func spec() {
        var subject: RealEarthquakeService!
        var httpClient: FakeHTTPClient!
        var earthquakeClusterDeserializer: FakeEarthquakeClusterDeserializer!

        beforeEach {
            httpClient = FakeHTTPClient()
            earthquakeClusterDeserializer = FakeEarthquakeClusterDeserializer()
            subject = RealEarthquakeService(httpClient: httpClient, deserializer: earthquakeClusterDeserializer)
        }

        describe("getting a list of San Ramon earthquakes") {
            var promise: Promise<Void>!

            beforeEach {
                promise = subject.getSanRamonEarthquakes()
            }

            it("makes a request to the HTTP client") {
                expect(httpClient.get_wasCalled).to(beTrue())

                let expectedURL = "http://earthquake.usgs.gov/fdsnws/event/1/count?format=geojson&latitude=37.7800&longitude=-121.9871&maxradiuskm=5&starttime=2015-10-01"
                expect(httpClient.get_wasCalled_withURL).to(equal(expectedURL))
            }

            it("returns a pending promise") {
                expect(promise.pending).to(beTrue())
            }

            describe("when the request succeeds") {
                beforeEach {
                    httpClient.fulfillLastRequest?(["fake": "response"])
                }

                it("tries to deserialize the response") {
                    expect(earthquakeClusterDeserializer.deserialize_wasCalled).to(beTrue())
                    expect(earthquakeClusterDeserializer.deserialize_wasCalled_withRepresentation).to(equal(["fake": "response"]))
                }

                describe("when deserialization succeeds") {

                }

                describe("when a deserialization error occurs") {
                    
                }
            }

            describe("when the request fails") {
                beforeEach {
                    let error = NSError(domain: "Fake Error", code: 0, userInfo: nil)
                    httpClient.rejectLastRequest?(error)
                }
            }
        }
    }
}
