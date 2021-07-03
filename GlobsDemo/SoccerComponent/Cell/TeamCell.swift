//
//  TeamCell.swift
//  GlobsDemo
//
//  Created by Tal talspektor on 02/07/2021.
//

import UIKit

class TeamCell: UITableViewCell {

    static let reusableIdentifier = String(describing: TeamCell.self)
    static let nib = UINib(nibName: String(describing: TeamCell.self), bundle: nil)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(name: String?, description: String?) {
        nameLabel.text = name
        descriptionLabel.text = description
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
}
