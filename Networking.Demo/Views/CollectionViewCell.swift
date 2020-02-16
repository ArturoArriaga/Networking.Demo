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
    
    let imageView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 125).isActive = true
        return v
    }()
    
    let trailingStackView = MovieDescriptionStackView()
    
    
    lazy var baseStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, trailingStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        self.addSubview(baseStackView)
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

