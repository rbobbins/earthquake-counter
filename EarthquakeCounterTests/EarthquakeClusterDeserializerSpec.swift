import Quick
import Nimble
@testable import EarthquakeCounter
import Foundation

class EarthquakeClusterDeserializerSpec: QuickSpec {

    override func spec() {
        var jsonRepresentation: NSDictionary!
        var subject: RealEarthquakeClusterDeserializer!

        beforeEach {
            let bundle = Bundle(for: EarthquakeClusterDeserializerSpec.self)
            let pathToJson = bundle.path(forResource: "response", ofType: "json")
            if let pathToJson = pathToJson,
                let jsonData = NSData(contentsOfFile: pathToJson)
            {
                jsonRepresentation = try! JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary
            }
            expect(jsonRepresentation).notTo(beNil())
            subject = RealEarthquakeClusterDeserializer()
        }
        
        describe("deserializing a JSON representation") {
            context("when JSON has expected structure") {
                it("returns an EarthquakeCluster") {
                    let date1 = Date(timeIntervalSince1970: 1445312276)
                    let earthquake1 = Earthquake(date: date1, magnitude: 1.37, place: "1km NNE of San Ramon, California")
                    let result = subject.deserialize(jsonRepresentation)

                    expect(result.value?.count).to(equal(223))
                    expect(result.value?.first).to(equal(earthquake1))
                }
            }

            context("when JSON is malformed") {
                it("rejects the promsie with an error") {
                    let badRepresentation: NSDictionary = ["blargh": []]
                    let result = subject.deserialize(badRepresentation)
                    expect(result.isRejected).to(beTrue())

                    let error = result.error as? EarthquakeDeserializationError
                    expect(error?.description).to(contain("JSON response does not contain list of features"))
                }
            }
        }
    }
}
