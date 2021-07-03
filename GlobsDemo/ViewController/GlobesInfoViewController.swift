//
//  GlobsInfoViewController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class GlobesInfoViewController: UIViewController, Storyboarded, TabBatItemProtocol, BaseViewController {
    
    enum SegmentPresentingState: Int {
        case cars = 0
        case sportsAndCulture = 1
    }

    var coordinator: SoccerCoordinator?
    var didSelectCell: ((String?) -> Void)?
    var viewModel: GlobesInfoViewModel?
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndecatorView: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAll()
        activityIndecatorView.startAnimating()
        listenToViewModelUpdates()
    }

    private func listenToViewModelUpdates() {
        viewModel?.refreshData = { [weak self] in
            self?.refreshData()
        }
        viewModel?.startAnimate = { [weak self] in
            self?.startAnimate()

        }
        viewModel?.stopAnimate = { [weak self] in
            self?.stopAnimate()
        }
    }

    private func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func startAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndecatorView.startAnimating()
            self?.activityIndecatorView.isHidden = false
        }
    }

    private func stopAnimate() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndecatorView.stopAnimating()
            self?.activityIndecatorView.isHidden = true
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GlobesCell.reuseIdentifier, for: indexPath) as? GlobesCell else {
            fatalError("can't dequeue cell")
        }
        let title = viewModel?.dataModel[indexPath.row].title ?? ""
        let description = viewModel?.dataModel[indexPath.row].description ?? ""
        cell.configure(title: title, description: description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleLastSelection(index: indexPath.row)

        showDetails(index: indexPath.row)
    }

    private func handleLastSelection(index: Int) {
        viewModel?.lastSelection = viewModel?.dataModel[index].title
        didSelectCell?(viewModel?.dataModel[index].title)
    }

    private func showDetails(index: Int) {
        let name = viewModel?.dataModel[index].title
        let league = viewModel?.dataModel[index].description
        coordinator?.showDetails(name: name, league: league)
    }
}

