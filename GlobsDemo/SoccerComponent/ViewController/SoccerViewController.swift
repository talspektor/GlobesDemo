//
//  SoccerViewController.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import UIKit

class SoccerViewController: UIViewController, ViewContorllerType {

    enum SegmentPresentingState: Int {
        case spain = 0
        case englandAndFrance = 1
    }

    static let identifier = String(describing: SoccerViewController.self)

    var didSelectCell: ((String?) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var activityIndecatorView: UIActivityIndicatorView!

    var viewModel: SoccerViewModel?

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
            print("startAnimate")
            self?.startAnimate()

        }
        viewModel?.stopAnimate = { [weak self] in
            print("stopAnimate")
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
        viewModel?.lastSelection = viewModel?.dataModel[indexPath.row].strTeam
        didSelectCell?(viewModel?.dataModel[indexPath.row].strTeam)
        let storyboard = UIStoryboard(name: DetailViewController.identifier, bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        let name = viewModel?.dataModel[indexPath.row].strTeam
        let league = viewModel?.dataModel[indexPath.row].strLeague
        detailViewController.setText(name: name, league: league)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
