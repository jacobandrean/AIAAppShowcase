//
//  StockTableViewCell.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 25/04/21.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    static let identifier = "CategoryTableViewCell"
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.addSubview(openLabel)
        contentView.addSubview(highLabel)
        contentView.addSubview(lowLabel)
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
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            openLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            openLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            highLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 10),
            highLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            highLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10),
            lowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            lowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func configureCell(date: String, open: String, high: String, low: String) {
        isUserInteractionEnabled = false
        dateLabel.text = date
        openLabel.text = "Open :   \(open)"
        highLabel.text = "High  :   \(high)"
        lowLabel.text  = "Low   :   \(low)"
    }
    
}
