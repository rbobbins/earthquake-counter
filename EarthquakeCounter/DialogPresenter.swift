import UIKit

public protocol DialogPresenter {
    func present(_ title: String, message: String?, onTryAgain: @escaping ((Void) -> Void), onTopOf presenter: UIViewController)
}

class RealDialogPresenter: DialogPresenter {
    open func present(_ title: String, message: String?, onTryAgain: @escaping ((Void) -> Void), onTopOf presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { _ in onTryAgain() }
        alert.addAction(tryAgainAction)
        
        presenter.present(alert, animated: true, completion: nil)
    }
}
