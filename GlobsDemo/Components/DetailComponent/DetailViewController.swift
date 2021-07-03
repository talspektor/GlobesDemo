//
//  DetailViewController.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import UIKit
import Coordinator

class DetailViewController: UIViewController, Storyboarded {

    static let identifier = String(describing: DetailViewController.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!

    var name: String?
    var league: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        leagueLabel.text = league
    }

    func setText(name: String?, league: String?) {
        self.name = name
        self.league = league
    }
}
