import Quick
import Nimble
@testable import EarthquakeCounter

class EarthquakeSpec: QuickSpec {
    override func spec() {

        describe("equality") {
            let subject = Earthquake(date: NSDate(), magnitude: 1.2, place: "SF")

            it("is equal when all properties have the samve values") {
                let date = subject.date.copy() as! NSDate
                let other = Earthquake(date: date, magnitude: subject.magnitude, place: subject.place)
                expect(subject == other).to(beTrue())
            }

            it("is not equal when any properties differ") {
                let other1 = Earthquake(date: NSDate(timeInterval: 1, sinceDate: subject.date), magnitude: subject.magnitude, place: subject.place)
                expect(subject == other1).to(beFalse())

                let other2 = Earthquake(date: subject.date, magnitude: 9.99, place: subject.place)
                expect(subject == other2).to(beFalse())

                let other3 = Earthquake(date: subject.date, magnitude: subject.magnitude, place: "NY")
                expect(subject == other3).to(beFalse())

            }
        }

    }
}
