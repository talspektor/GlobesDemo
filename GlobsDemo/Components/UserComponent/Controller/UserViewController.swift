//
//  UserViewController.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit
import Coordinator

class UserViewController: UIViewController, Storyboarded, TabBatItemProtocol, BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastSelectionLabel: UILabel!
    
    var viewModel: UserViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }

    private func setupUI() {
        nameLabel.text = viewModel?.userName
        timeLabel.text = viewModel?.currentTime
        lastSelectionLabel.text = viewModel?.lastSelection
    }
}
