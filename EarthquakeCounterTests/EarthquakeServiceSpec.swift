import Quick
import Nimble
import PromiseKit
@testable import EarthquakeCounter

class EarthquakeServiceSpec: QuickSpec {
    override func spec() {
        var subject: RealEarthquakeService!
        var httpClient: FakeHTTPClient!

        beforeEach {
            httpClient = FakeHTTPClient()
            subject = RealEarthquakeService(httpClient: httpClient)
        }

        describe("getting a list of San Ramon earthquakes") {
            beforeEach {
                subject.getSanRamonEarthquakes()
            }

            it("makes a request to the HTTP client") {
                expect(httpClient.get_wasCalled).to(beTrue())

                let expectedURL = "http://earthquake.usgs.gov/fdsnws/event/1/count?format=geojson&latitude=37.7800&longitude=-121.9871&maxradiuskm=5&starttime=2015-10-01"
                expect(httpClient.get_wasCalled_withURL).to(equal(expectedURL))
            }

            describe("when the request succeeds") {
                describe("when deserialization succeeds") {

                }

                describe("when a deserialization error occurs") {
                    
                }
            }

            describe("when the request fails") {
                
            }
        }
    }
}
