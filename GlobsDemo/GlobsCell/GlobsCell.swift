//
//  GlobsCell.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class GlobsCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: GlobsCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(title: String, description: String) {
        titleLabel?.text = title
        descriptionLabel?.text = description
    }
}
