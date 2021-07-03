//
//  GlobsInfoViewController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class GlobesInfoViewController: UIViewController, ViewContorllerType {
    
    enum SegmentPresentingState: Int {
        case cars = 0
        case sportsAndCulture = 1
    }

    static let identifier = String(describing: GlobesInfoViewController.self)
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndecatorView: UIActivityIndicatorView!
    
    var viewModel: GlobsInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAll()
        activityIndecatorView.startAnimating()
        viewModel?.refreshData = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        viewModel?.startAnimate = {
            print("startAnimate")
            DispatchQueue.main.async { [weak self] in
                self?.activityIndecatorView.startAnimating()
                self?.activityIndecatorView.isHidden = false
            }
            
        }
        viewModel?.stopAnimate = {
            print("stopAnimate")
            DispatchQueue.main.async { [weak self] in
                self?.activityIndecatorView.stopAnimating()
                self?.activityIndecatorView.isHidden = true
            }
        }
    }
    
    @IBAction func segmentDidSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case SegmentPresentingState.cars.rawValue:
            viewModel?.switchToCars()
        case SegmentPresentingState.sportsAndCulture.rawValue:
            viewModel?.switchToSportAndCulture()
        default: break
        }
    }
}

extension GlobesInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GlobsCell.reuseIdentifier, for: indexPath) as? GlobsCell else {
            fatalError("can't dequeue cell")
        }
        let title = viewModel?.dataModel[indexPath.row].title ?? ""
        let description = viewModel?.dataModel[indexPath.row].description ?? ""
        cell.configure(title: title, description: description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GlobsCell else { return }
        viewModel?.lastSelection = cell.titleLabel.text
    }
}

