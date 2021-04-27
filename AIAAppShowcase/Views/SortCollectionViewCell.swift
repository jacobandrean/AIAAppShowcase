//
//  SortCollectionViewCell.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 27/04/21.
//

import UIKit

class SortCollectionViewCell: UICollectionViewCell {
    static let identifier = "SortCollectionViewCell"
    
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        addSubview(sortLabel)
        
        setupViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewConstraint() {
        NSLayoutConstraint.activate([
            sortLabel.topAnchor.constraint(equalTo: topAnchor),
            sortLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            sortLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            sortLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    public func configureCell(sortBy: String) {
        sortLabel.text = sortBy
    }
    
    public func selectCell() {
        backgroundColor = .gray
    }
    
}
