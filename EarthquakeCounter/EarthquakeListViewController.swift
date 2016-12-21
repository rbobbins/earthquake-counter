//
//  EarthquakeListViewController.swift
//  EarthquakeCounter
//
//  Created by Rachel Bobbins on 10/17/15.
//  Copyright © 2015 Rachel Bobbins. All rights reserved.
//

import UIKit

class EarthquakeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let earthquakeService: EarthquakeService
    fileprivate var earthquakeCluster: EarthquakeCluster? = nil

    init(earthquakeService: EarthquakeService = RealEarthquakeService()) {
        self.earthquakeService = earthquakeService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EarthquakeTableViewCell.self, forCellReuseIdentifier: EarthquakeTableViewCell.cellIdentifier)

        _ = earthquakeService.getSanRamonEarthquakes()
            .then { earthquakeCluster -> Void in
                self.earthquakeCluster = earthquakeCluster
                self.tableView.reloadData()
        }
    }
}

extension EarthquakeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.earthquakeCluster != nil ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.earthquakeCluster?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EarthquakeTableViewCell.cellIdentifier)!
        cell.textLabel?.text = "Earthquake: \(indexPath.row)"
        return cell
    }
}
