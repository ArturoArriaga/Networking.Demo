//
//  CollectionViewCell.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/15/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit


class MovieViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieViewCellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
