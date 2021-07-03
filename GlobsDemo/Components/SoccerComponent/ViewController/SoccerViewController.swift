//
//  SoccerViewController.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import UIKit

class SoccerViewController: UIViewController, Storyboarded, TabBatItemProtocol {

    private enum SegmentPresentingState: Int {
        case spain = 0
        case englandAndFrance = 1
    }
    var coordinator: SoccerCoordinator?
    var didSelectCell: ((String?) -> Void)?
    var viewModel: SoccerViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var activityIndecatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamCell.nib, forCellReuseIdentifier: TeamCell.reusableIdentifier)
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

    @IBAction func didSwitchSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case SegmentPresentingState.spain.rawValue:
            viewModel?.switchToSpain()
        case SegmentPresentingState.englandAndFrance.rawValue:
            viewModel?.switchToEnglandAndFrance()
        default: break
        }
    }
}

extension SoccerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.dataModel.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reusableIdentifier, for: indexPath) as! TeamCell
        let name = viewModel?.dataModel[indexPath.row].strTeam
        let league = viewModel?.dataModel[indexPath.row].strLeague
        cell.configure(name: name, description: league)
        return cell
    }


}

extension SoccerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleLastSelection(index: indexPath.row)

        showDetails(index: indexPath.row)
    }

    private func handleLastSelection(index: Int) {
        viewModel?.lastSelection = viewModel?.dataModel[index].strTeam
        didSelectCell?(viewModel?.dataModel[index].strTeam)
    }

    private func showDetails(index: Int) {
        let name = viewModel?.dataModel[index].strTeam
        let league = viewModel?.dataModel[index].strLeague
        coordinator?.showDetails(name: name, league: league)
    }
}
