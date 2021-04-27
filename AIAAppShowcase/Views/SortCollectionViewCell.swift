//
//  SortCollectionViewCell.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 27/04/21.
//

import UIKit

protocol SortCollectionViewCellDelegate {
    func sortStock(_ sender: UIButton)
}

class SortCollectionViewCell: UICollectionViewCell {
    
    var delegate: SortCollectionViewCellDelegate?
    
    static let identifier = "SortCollectionViewCell"
    
    private var highestOpenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Highest Open", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var lowestOpenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lowest Open", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 1
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var highestHighButton: UIButton = {
        let button = UIButton()
        button.setTitle("Highest High", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var lowestHighButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lowest High", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var highestLowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Highest Low", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var lowestLowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lowest Low", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var newestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Newest", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var oldestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Oldest", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tag = 7
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(highestOpenButton)
        contentView.addSubview(lowestOpenButton)
        contentView.addSubview(highestHighButton)
        contentView.addSubview(lowestHighButton)
        contentView.addSubview(highestLowButton)
        contentView.addSubview(lowestLowButton)
        contentView.addSubview(newestButton)
        contentView.addSubview(oldestButton)
        highestOpenButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        lowestOpenButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        highestHighButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        lowestHighButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        highestLowButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        lowestLowButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        newestButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        oldestButton.addTarget(self, action: #selector(sortStock), for: .touchUpInside)
        
        setupViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sortStock(_ sender: UIButton) {
        delegate?.sortStock(sender)
        let buttons = [highestOpenButton, lowestOpenButton, highestHighButton, lowestHighButton, highestLowButton, lowestLowButton, newestButton, oldestButton]
        buttons.forEach({$0.backgroundColor = nil})
        switch sender.tag {
        case 0:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 1:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 2:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 3:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 4:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 5:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 6:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        case 7:
            sender.backgroundColor = sender.backgroundColor == nil ? UIColor.systemFill : nil
        default:
            break
        }
    }
    
    private func setupViewConstraint() {
        NSLayoutConstraint.activate([
            highestOpenButton.topAnchor.constraint(equalTo: topAnchor),
            highestOpenButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            highestOpenButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            highestOpenButton.widthAnchor.constraint(equalToConstant: 150),
            
            lowestOpenButton.topAnchor.constraint(equalTo: topAnchor),
            lowestOpenButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            lowestOpenButton.leadingAnchor.constraint(equalTo: highestOpenButton.trailingAnchor, constant: 10),
            lowestOpenButton.widthAnchor.constraint(equalToConstant: 150),
            
            highestHighButton.topAnchor.constraint(equalTo: topAnchor),
            highestHighButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            highestHighButton.leadingAnchor.constraint(equalTo: lowestOpenButton.trailingAnchor, constant: 10),
            highestHighButton.widthAnchor.constraint(equalToConstant: 150),
            
            lowestHighButton.topAnchor.constraint(equalTo: topAnchor),
            lowestHighButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            lowestHighButton.leadingAnchor.constraint(equalTo: highestHighButton.trailingAnchor, constant: 10),
            lowestHighButton.widthAnchor.constraint(equalToConstant: 150),
            
            highestLowButton.topAnchor.constraint(equalTo: topAnchor),
            highestLowButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            highestLowButton.leadingAnchor.constraint(equalTo: lowestHighButton.trailingAnchor, constant: 10),
            highestLowButton.widthAnchor.constraint(equalToConstant: 150),
            
            lowestLowButton.topAnchor.constraint(equalTo: topAnchor),
            lowestLowButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            lowestLowButton.leadingAnchor.constraint(equalTo: highestLowButton.trailingAnchor, constant: 10),
            lowestLowButton.widthAnchor.constraint(equalToConstant: 150),
            
            newestButton.topAnchor.constraint(equalTo: topAnchor),
            newestButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            newestButton.leadingAnchor.constraint(equalTo: lowestLowButton.trailingAnchor, constant: 10),
            newestButton.widthAnchor.constraint(equalToConstant: 150),
            
            oldestButton.topAnchor.constraint(equalTo: topAnchor),
            oldestButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            oldestButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            oldestButton.leadingAnchor.constraint(equalTo: newestButton.trailingAnchor, constant: 10),
            oldestButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
}
