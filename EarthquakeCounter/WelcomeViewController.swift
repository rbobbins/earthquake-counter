import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var simpleSpinnerLabel: UILabel!
    @IBOutlet weak var simpleSpinner: UIActivityIndicatorView!
    @IBOutlet weak var simpleSpinnerButton: UIButton!

    @IBOutlet weak var earthquakeSpinner: UIActivityIndicatorView!
    @IBOutlet weak var earthquakeButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapSimpleSpinnerButton(sender: AnyObject) {
        toggleSpinner()
    }

    @IBAction func didTapEarthquakeButton(sender: AnyObject) {
        //no-op, for now
    }

    //MARK: Private
    private func toggleSpinner() {
        switch simpleSpinner.isAnimating() {
        case true: simpleSpinner.stopAnimating()
        case false: simpleSpinner.startAnimating()
        }
    }

}
