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
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 125).isActive = true
        return v
    }()
    
    let topSpacerView: UIView = {
        let v = UIView()
        v.backgroundColor = .purple
        return v
    }()
    
    let spacerView1: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
        return v
    }()
    
    
    let directorNameLabel: UILabel = {
        let v = UILabel()
        v.text = "Director: Name"
        v.backgroundColor = .orange
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.font = .systemFont(ofSize: 16)
        return v
    }()
    
    let greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return v
    }()
    
    let movieNameLavel: UILabel = {
        let v = UILabel()
        v.text = "Fight Club"
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 150).isActive = true
        v.numberOfLines = 0
        v.backgroundColor = .systemPink
        v.font = .boldSystemFont(ofSize: 20)
        return v
    }()
    
    let movieRatingsLabel: UILabel = {
        let v = UILabel()
        v.text = "9.0"
        v.textAlignment = .center
        v.backgroundColor = .systemGray
        v.font = .boldSystemFont(ofSize: 20)
        return v
    }()

    
    lazy var titleAndRatingStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [movieNameLavel, spacerView1, movieRatingsLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sv.distribution = .fill
        return sv
    }()
    
    lazy var rightStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [topSpacerView ,titleAndRatingStackView, directorNameLabel, greenView])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.spacing = 2
        v.axis = .vertical
        v.distribution = .fill
        return v
    }()
    
    
    lazy var baseStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, rightStackView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.addSubview(baseStackView)
        
        
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

