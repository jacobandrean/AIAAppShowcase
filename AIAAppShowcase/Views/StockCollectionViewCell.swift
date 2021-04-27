//
//  StockCollectionViewCell.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 27/04/21.
//

import UIKit

class StockCollectionViewCell: UICollectionViewCell {
    static let identifier = "StockCollectionViewCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        addSubview(dateLabel)
        addSubview(openLabel)
        addSubview(highLabel)
        addSubview(lowLabel)
        backgroundColor = .secondarySystemBackground
        setupViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        openLabel.text = nil
        highLabel.text = nil
        lowLabel.text  = nil
    }
    
    private func setupViewConstraint() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            openLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            openLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            highLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 10),
            highLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            highLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10),
            lowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            lowLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    public func configureCell(date: String, open: String?, high: String?, low: String?) {
        guard let open = open,
              let high = high,
              let low = low else {
            return
        }
        dateLabel.text = date
        openLabel.text = "Open :   \(open)"
        highLabel.text = "High  :   \(high)"
        lowLabel.text  = "Low   :   \(low)"
    }
    
}
