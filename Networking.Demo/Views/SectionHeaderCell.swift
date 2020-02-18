//
//  HeaderLabel.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/16/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit


class HeaderLabelCell: UICollectionViewCell {
    static let reuseIdentifier = "HeaderCellId"
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "STAR WARS"
        l.font = .boldSystemFont(ofSize: 20)
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
