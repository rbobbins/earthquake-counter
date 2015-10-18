import Quick
import Nimble
@testable import EarthquakeCounter

class EarthquakeViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: EarthquakeViewController!
        beforeEach {
            subject = EarthquakeViewController()

            //This assertertion triggers the view controller to load its view.
            expect(subject.view).notTo(beNil())
        }

        it("should have welcome text") {
            expect(subject.titleLabel.text).to(equal("Welcome"))
        }
    }
}
