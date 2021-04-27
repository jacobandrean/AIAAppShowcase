//
//  ComparisonTableViewCell.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 26/04/21.
//

import UIKit

class ComparisonTableViewCell: UITableViewCell {

    static let identifier = "ComparisonTableViewCell"
    
    private let firstSymbolLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondSymbolLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thirdSymbolLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = false
        contentView.addSubview(firstSymbolLabel)
        contentView.addSubview(secondSymbolLabel)
        contentView.addSubview(thirdSymbolLabel)
        setupViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        firstSymbolLabel.text = nil
        secondSymbolLabel.text = nil
        thirdSymbolLabel.text  = nil
    }
    
    private func setupViewConstraint() {
        NSLayoutConstraint.activate([
            firstSymbolLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10),
            firstSymbolLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20),
            firstSymbolLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20),

            secondSymbolLabel.topAnchor.constraint(
                equalTo: firstSymbolLabel.bottomAnchor,
                constant: 10),
            secondSymbolLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20),
            secondSymbolLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20),

            thirdSymbolLabel.topAnchor.constraint(
                equalTo: secondSymbolLabel.bottomAnchor,
                constant: 10),
            thirdSymbolLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20),
            thirdSymbolLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20),
            thirdSymbolLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10)
        ])
    }
    
    public func configureCell(
        firstSymbol: String?, firstChart: TimeSeriesDaily?,
        secondSymbol: String?, secondChart: TimeSeriesDaily?,
        thirdSymbol: String?, thirdChart: TimeSeriesDaily?
    ) {
        if let first = firstChart {
            firstSymbolLabel.text  = "\(firstSymbol ?? "")\nOpen  : \(first.open)\nLow     : \(first.low)"
        }
        
        if let second = secondChart {
            secondSymbolLabel.text = "\(secondSymbol ?? "")\nOpen  : \(second.open)\nLow    : \(second.low)"
        }
        
        if let third = thirdChart {
            thirdSymbolLabel.text  = "\(thirdSymbol ?? "")\nOpen  : \(third.open)\nLow    : \(third.low)"
        }
        
    }


}

