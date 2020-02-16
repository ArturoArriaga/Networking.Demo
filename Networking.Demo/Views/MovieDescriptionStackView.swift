//
//  MovieDescriptionStackView.swift
//  Networking.Demo
//
//  Created by Art Arriaga on 2/16/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit

class MovieDescriptionStackView: UIStackView {
    
    lazy var topSpacerView = createSpacerView()
    
    lazy var titleAndRatingStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [movieNameLabel, spacerView1, movieRatingsLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sv.distribution = .fill
        return sv
    }()
    
    let movieNameLabel: UILabel = {
        let v = UILabel()
        v.text = "Fight Club"
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 150).isActive = true
        v.numberOfLines = 0
        v.font = .boldSystemFont(ofSize: 20)
        return v
    }()
    
    lazy var spacerView1 = createSpacerView()
    
    let movieRatingsLabel: UILabel = {
        let v = UILabel()
        v.text = "9.0"
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0.9984092116, green: 0.7378563285, blue: 0.01467877161, alpha: 1)
        v.font = .boldSystemFont(ofSize: 20)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let directorNameLabel: UILabel = {
        let v = UILabel()
        v.text = "Director: Name"
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.font = .systemFont(ofSize: 16)
        return v
    }()
    
    let descriptionLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 3
        v.text = "Chilo and mom and dad drive for home together. Blah blah blah"
        v.textColor = #colorLiteral(red: 0.709620595, green: 0.7137866616, blue: 0.7136848569, alpha: 1)
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return v
    }()

    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.distribution = .fill
        
        [topSpacerView, titleAndRatingStackView, directorNameLabel, descriptionLabel].forEach { (v) in
            addArrangedSubview(v)
            
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDescriptionStackView {
    private func createSpacerView () -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemBackground
        return v
    }
}
