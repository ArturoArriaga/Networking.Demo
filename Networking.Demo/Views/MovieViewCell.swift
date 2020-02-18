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
    
    var movieResult: Result! {
        didSet {
            self.trailingStackView.movieNameLabel.text = movieResult.trackName
            self.trailingStackView.directorNameLabel.text = movieResult.artistName
            self.trailingStackView.descriptionLabel.text = movieResult.shortDescription
        }
    }
    
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
    
    let grayBackGroundView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 140).isActive = true
        v.layer.cornerRadius = 12
        v.backgroundColor = .secondarySystemBackground
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(grayBackGroundView)
        self.addSubview(baseStackView)
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            grayBackGroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            grayBackGroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            grayBackGroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

