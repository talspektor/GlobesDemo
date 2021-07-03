//
//  GlobsCell.swift
//  GlobsDemo
//
//  Created by Zemingo on 23/06/2021.
//

import UIKit

class GlobesCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: GlobesCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(title: String, description: String) {
        titleLabel?.text = title
        descriptionLabel?.text = description
    }
}
