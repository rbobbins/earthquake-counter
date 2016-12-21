import Quick
import Nimble
import PromiseKit
@testable import EarthquakeCounter

class EarthquakeListViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: EarthquakeListViewController!
        var earthquakeService: FakeEarthquakeService!
        var deferredRequest: (promise: Promise<EarthquakeCluster>, fulfill: (EarthquakeCluster) -> Void, reject: (Error) -> Void)!

        beforeEach {
            deferredRequest = EarthquakeClusterPromise.pending()
            earthquakeService = FakeEarthquakeService()
            earthquakeService.stub_getSanRamonEarthquakes = deferredRequest.promise
            subject = EarthquakeListViewController(earthquakeService: earthquakeService)

            //This assertertion triggers the view controller to load its view.
            expect(subject.view).notTo(beNil())
        }

        it("should immediately make a request for a list of earthquakes") {
            expect(earthquakeService.getSanRamonEarthquakes_wasCalled).to(beTrue())
        }

        it("initially has an empty table view") {
            expect(subject.tableView.numberOfSections).to(equal(0))
        }

        describe("after succeeding at the request for earthquakes") {
            beforeEach {
                let e1 = Earthquake(date: Date(), magnitude: 1.2, place: "Stitch Fix")
                let e2 = Earthquake(date: Date(), magnitude: 1.6, place: "Realm")
                let cluster = EarthquakeCluster([e1, e2])
                deferredRequest.fulfill(cluster)
                advanceRunLoopSlightly()
            }

            it("shows a list of earthquakes") {
                expect(subject.tableView.numberOfSections).to(equal(1))
                expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(2))
            }

            xit("lists the location and magnitude for each quake") {

            }
        }
    }
}
