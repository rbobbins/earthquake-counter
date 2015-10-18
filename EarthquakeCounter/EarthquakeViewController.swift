//
//  EarthquakeViewController.swift
//  EarthquakeCounter
//
//  Created by Rachel Bobbins on 10/17/15.
//  Copyright © 2015 Rachel Bobbins. All rights reserved.
//

import UIKit

class EarthquakeViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    private let earthquakeService: EarthquakeService


    init(earthquakeService: EarthquakeService = RealEarthquakeService()) {
        self.earthquakeService = earthquakeService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        earthquakeService.getSanRamonEarthquakes()
    }
}
