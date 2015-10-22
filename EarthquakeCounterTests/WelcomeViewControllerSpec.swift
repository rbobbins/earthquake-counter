import Quick
import Nimble
@testable import EarthquakeCounter

class WelcomeViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: WelcomeViewController!
        var earthquakeService: FakeEarthquakeService!

        beforeEach {
            earthquakeService = FakeEarthquakeService()
            subject = WelcomeViewController()

            //Trigger the view to load and assert that it's not nil
            expect(subject.view).notTo(beNil())
        }

        it("labels the examples") {
            expect(subject.simpleSpinnerLabel.text).to(equal("Example #1: Spinners"))
        }

        it("has no moving spinners") {
            expect(subject.simpleSpinner.isAnimating()).to(beFalse())
            expect(subject.earthquakeSpinner.isAnimating()).to(beFalse())
        }

        it("has the correct title for the example #1 button") {
            expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Start spinner"))
        }

        describe("tapping the simple spinner button") {
            beforeEach {
                subject.simpleSpinnerButton.sendActionsForControlEvents(.TouchUpInside)
            }

            it("animates the spinner") {
                expect(subject.simpleSpinner.isAnimating()).to(beTrue())
            }

            it("updates the correct title for the example #1 button") {
                expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Stop spinner"))
            }


            describe("tapping the button again") {
                beforeEach {
                    subject.simpleSpinnerButton.sendActionsForControlEvents(.TouchUpInside)
                }

                it("stops the spinner") {
                    expect(subject.simpleSpinner.isAnimating()).to(beFalse())
                }

                it("updates the correct title for the example #1 button") {
                    expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Start spinner"))
                }
            }
        }

        describe("tapping the earthquake button") {
            beforeEach {
                subject.earthquakeButton.sendActionsForControlEvents(.TouchUpInside)
            }

            it("makes a request for the number of earthquakes in San Ramon") {
                expect(earthquakeService.getSanRamonEarthquakes_wasCalled).to(beTrue())
            }

            it("starts a spinner") {
                expect(subject.earthquakeSpinner.isAnimating()).to(beTrue())
            }

            describe("when the request succeeds") {
                describe("presenting an alert with the # of earthquakes") {
                    it("includes the correct number") {

                    }

                    it("includes the option to dismiss the alert") {

                    }

                    it("includes the option to search again") {

                    }

                    describe("when the user decides to search again") {
                        it("makes another request to the network") {

                        }
                    }
                }
            }

            describe("when the request fails") {

            }
        }
    }
}
