import UIKit

public protocol DialogPresenter {
    func present(title: String, message: String?, onTryAgain: (Void -> Void), onTopOf presenter: UIViewController)
}

class RealDialogPresenter: DialogPresenter {
    func present(title: String, message: String?, onTryAgain: (Void -> Void), onTopOf presentingViewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)

        let tryAgainAction = UIAlertAction(title: "Try Again", style: .Default) { _ in onTryAgain() }
        alert.addAction(tryAgainAction)

        presentingViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
