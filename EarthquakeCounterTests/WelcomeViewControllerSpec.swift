import Quick
import Nimble
@testable import EarthquakeCounter

class WelcomeViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: WelcomeViewController!
        var earthquakeService: FakeEarthquakeService!
        var dialogPresenter: FakeDialogPresenter!
        var deferredRequest: (promise: EarthquakeClusterPromise, fulfill: (EarthquakeCluster) -> Void, reject: (Error) -> Void)!

        beforeEach {
            earthquakeService = FakeEarthquakeService()
            deferredRequest = EarthquakeClusterPromise.pending()
            earthquakeService.stub_getSanRamonEarthquakes = deferredRequest.promise

            dialogPresenter = FakeDialogPresenter()

            //Inject dependencies into the view controller
            subject = WelcomeViewController(earthquakeService: earthquakeService,
                dialogPresenter: dialogPresenter)

            //Trigger the view to load and assert that it's not nil
            expect(subject.view).notTo(beNil())
        }

        it("labels the examples") {
            expect(subject.simpleSpinnerLabel.text).to(equal("Example #1: Spinners"))
        }

        it("has no moving spinners") {
            expect(subject.simpleSpinner.isAnimating).to(beFalse())
            expect(subject.earthquakeSpinner.isAnimating).to(beFalse())
        }

        it("has the correct title for the example #1 button") {
            expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Start spinning"))
        }

        describe("tapping the simple spinner button") {
            beforeEach {
                subject.simpleSpinnerButton.sendActions(for: .touchUpInside)
            }

            it("animates the spinner") {
                expect(subject.simpleSpinner.isAnimating).to(beTrue())
            }

            it("updates the correct title for the example #1 button") {
                expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Stop spinning"))
            }


            describe("tapping the button again") {
                beforeEach {
                    subject.simpleSpinnerButton.sendActions(for: .touchUpInside)
                }

                it("stops the spinner") {
                    expect(subject.simpleSpinner.isAnimating).to(beFalse())
                }

                it("updates the correct title for the example #1 button") {
                    expect(subject.simpleSpinnerButton.titleLabel?.text).to(equal("Start spinning"))
                }
            }
        }

        describe("tapping the earthquake button") {
            beforeEach {
                subject.earthquakeButton.sendActions(for: .touchUpInside)
            }

            it("makes a request for the number of earthquakes in San Ramon") {
                //Test that the correct message gets sent to the service
                expect(earthquakeService.getSanRamonEarthquakes_wasCalled).to(beTrue())
            }

            it("starts a spinner") {
                expect(subject.earthquakeSpinner.isAnimating).to(beTrue())
            }

            describe("when the request succeeds") {
                beforeEach {
                    let earthquakeCluster = EarthquakeCluster([])
                    deferredRequest.fulfill(earthquakeCluster)
                    advanceRunLoopSlightly()
                }

                it("stops the spinner") {
                    expect(subject.earthquakeSpinner.isAnimating).to(beFalse())
                }

                it("presents an alert") {
                    expect(dialogPresenter.present_wasCalled).to(beTrue())
                }
                describe("telling the dialog presenter to present an alert with the # of earthquakes") {
                    it("includes the correct number") {
                        let expectedTitle = "Earthquakes near San Ramon"
                        let actualTitle = dialogPresenter.present_wasCalled_withArgs?.title
                        expect(actualTitle).to(equal(expectedTitle))

                        let expectedMessage = "There have been 0 earthquakes near San Ramon since 10/1/2015"
                        let actualMessage = dialogPresenter.present_wasCalled_withArgs?.message
                        expect(actualMessage).to(equal(expectedMessage))
                    }

                    describe("when the user decides to search again") {
                        beforeEach {
                            earthquakeService.getSanRamonEarthquakes_wasCalled = false

                            let tryAgain = dialogPresenter.present_wasCalled_withArgs?.onTryAgain
                            tryAgain?()
                        }
                        it("makes another request to the network") {
                            expect(earthquakeService.getSanRamonEarthquakes_wasCalled).to(beTrue())
                        }
                    }
                }
            }

            describe("when the request fails") {

            }
        }
    }
}
