import EarthquakeCounter
import UIKit

class FakeDialogPresenter: DialogPresenter  {
    var present_wasCalled = false
    var present_wasCalled_withArgs: (title: String, message: String?, onTryAgain: ((Void) -> Void), presentingVC: UIViewController)? = nil

    func present(_ title: String, message: String?, onTryAgain: @escaping ((Void) -> Void), onTopOf presenter: UIViewController) {
        present_wasCalled = true
        present_wasCalled_withArgs = (title: title, message: message, onTryAgain: onTryAgain, presentingVC: presenter)
    }
}

