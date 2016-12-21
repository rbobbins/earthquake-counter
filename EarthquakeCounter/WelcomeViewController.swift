import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var simpleSpinnerLabel: UILabel!
    @IBOutlet weak var simpleSpinner: UIActivityIndicatorView!
    @IBOutlet weak var simpleSpinnerButton: UIButton!

    @IBOutlet weak var earthquakeSpinner: UIActivityIndicatorView!
    @IBOutlet weak var earthquakeButton: UIButton!

    let earthquakeService: EarthquakeService
    let dialogPresenter: DialogPresenter

    init(earthquakeService: EarthquakeService = RealEarthquakeService(),
        dialogPresenter: DialogPresenter = RealDialogPresenter())
    {
        self.earthquakeService = earthquakeService
        self.dialogPresenter = dialogPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapSimpleSpinnerButton(_ sender: AnyObject) {
        toggleSpinner()
    }

    @IBAction func didTapEarthquakeButton(_ sender: AnyObject) {
        makeRequestForEarthquakes()
    }

    //MARK: Private
    fileprivate func makeRequestForEarthquakes() {
        earthquakeSpinner.startAnimating()
        _ = earthquakeService.getSanRamonEarthquakes()
            .then { cluster -> Void in
                self.earthquakeSpinner.stopAnimating()
                //TODO: Move text to a different object. Maybe an EarthquakeClusterViewModel?
                self.dialogPresenter.present("Earthquakes near San Ramon",
                    message: "There have been \(cluster.count) earthquakes near San Ramon since 10/1/2015",
                    onTryAgain: self.makeRequestForEarthquakes,
                    onTopOf: self)

        }

        //TODO: Handle the case where network request fails

    }
    fileprivate func toggleSpinner() {
        switch simpleSpinner.isAnimating {
        case true:
            simpleSpinner.stopAnimating()
            simpleSpinnerButton.setTitle("Start spinning", for: UIControlState())
        case false:
            simpleSpinner.startAnimating()
            simpleSpinnerButton.setTitle("Stop spinning", for: UIControlState())
        }
    }

}
