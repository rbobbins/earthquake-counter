import Quick
import Nimble
@testable import EarthquakeCounter

class EarthquakeViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: EarthquakeViewController!
        var earthquakeService: FakeEarthquakeService!

        beforeEach {
            earthquakeService = FakeEarthquakeService()

            subject = EarthquakeViewController(earthquakeService: earthquakeService)

            //This assertertion triggers the view controller to load its view.
            expect(subject.view).notTo(beNil())
        }

        it("should have welcome text") {
            expect(subject.titleLabel.text).to(equal("Welcome"))
        }

        it("should immediately make a request for a list of earthquakes") {
            expect(earthquakeService.getSanRamonEarthquakes_wasCalled).to(beTrue())
        }

    }
}
