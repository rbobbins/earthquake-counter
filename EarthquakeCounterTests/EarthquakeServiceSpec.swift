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
            var promise: EarthquakeClusterPromise!

            beforeEach {
                promise = subject.getSanRamonEarthquakes()
            }

            it("makes a request to the HTTP client") {
                expect(httpClient.get_wasCalled).to(beTrue())

                let expectedURL = "http://earthquake.usgs.gov/fdsnws/event/1/query"
                expect(httpClient.get_wasCalled_withArgs?.url).to(equal(expectedURL))
                expect(httpClient.get_wasCalled_withArgs?.query).notTo(beNil())
            }

            it("returns a pending promise") {
                expect(promise.isPending).to(beTrue())
            }

            describe("when the request succeeds") {
                beforeEach {
                    httpClient.fulfillLastRequest(["fake": "response"])
                }

                it("tries to deserialize the response") {
                    expect(earthquakeClusterDeserializer.deserialize_wasCalled).to(beTrue())
                    expect(earthquakeClusterDeserializer.deserialize_wasCalled_withRepresentation).to(equal(["fake": "response"]))
                }

                describe("when deserialization succeeds") {
                    var deserializedEarthquakeCluster: EarthquakeCluster!

                    beforeEach {
                        let earthquake = Earthquake(date: NSDate() as Date, magnitude: 1.2, place: "4th and King")
                        deserializedEarthquakeCluster = EarthquakeCluster([earthquake])
                        earthquakeClusterDeserializer.succeedAtDeserializing?(deserializedEarthquakeCluster)
                        advanceRunLoopSlightly()
                    }

                    it("fulfills the promise") {
                        expect(promise.isFulfilled).to(beTrue())
                    }
                }

                describe("when a deserialization error occurs") {
                    var deserializationError: NSError!

                    beforeEach {
                        deserializationError = NSError(domain: "Fake Error", code: 0, userInfo: nil)
                        earthquakeClusterDeserializer.failAtDeserializing?(deserializationError)
                        advanceRunLoopSlightly()
                    }

                    it("rejects the promise") {
                        expect(promise.isRejected).to(beTrue())
                    }
                }
            }

            describe("when the request fails") {
                beforeEach {
                    let error = NSError(domain: "Fake Error", code: 0, userInfo: nil)
                    httpClient.rejectLastRequest(error)
                }

                it("rejects the promise") {
                    expect(promise.isRejected).to(beTrue())
                }
            }
        }
    }
}
