//
//  SettingViewController.swift
//  AIAAppShowcase
//
//  Created by Jacob Andrean on 24/04/21.
//

import UIKit

class SettingViewController: UIViewController {

    private let apiKeyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "API Key"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let intervalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Interval"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let outputSizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Output Size"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var apiKeyTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var outputSizeTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var intervalTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let outputSizePicker = UIPickerView()
    private let intervalPicker = UIPickerView()
    
    var apiKey = "KWFWUZ8HYAX1CBAJ"
    let intervals = ["1min", "5min", "15min", "30min", "60min"]
    let outputSizes = ["compact", "full"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        apiKeyLabel.frame = CGRect(
            x: 20,
            y: view.top+200,
            width: 100,
            height: 40
        )
        apiKeyTextField.frame = CGRect(
            x: apiKeyLabel.right+10,
            y: view.top+200,
            width: view.width - apiKeyLabel.width-50,
            height: 40
        )
        intervalLabel.frame = CGRect(
            x: 20,
            y: apiKeyTextField.bottom+40,
            width: 100,
            height: 40
        )
        intervalTextField.frame = CGRect(
            x: intervalLabel.right+10,
            y: apiKeyTextField.bottom+40,
            width: view.width - intervalLabel.width-50,
            height: 40
        )
        outputSizeLabel.frame = CGRect(
            x: 20,
            y: intervalTextField.bottom+40,
            width: 100,
            height: 40
        )
        outputSizeTextField.frame = CGRect(
            x: outputSizeLabel.right+10,
            y: intervalTextField.bottom+40,
            width: view.width - outputSizeLabel.width-50,
            height: 40
        )
    }
    
    private func configureView() {
        view.addSubview(apiKeyLabel)
        view.addSubview(intervalLabel)
        view.addSubview(outputSizeLabel)
        view.addSubview(apiKeyTextField)
        view.addSubview(intervalTextField)
        view.addSubview(outputSizeTextField)
        
        apiKeyTextField.text = "asd"
        intervalTextField.text = defaults.string(forKey: "Interval")
        outputSizeTextField.text = defaults.string(forKey: "OutputSize")
        
        intervalTextField.inputView = intervalPicker
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
        
        outputSizeTextField.inputView = outputSizePicker
        outputSizePicker.delegate = self
        outputSizePicker.dataSource = self
    }
    
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case intervalPicker:
            return intervals.count
        case outputSizePicker:
            return outputSizes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case intervalPicker:
            return intervals[row]
        case outputSizePicker:
            return outputSizes[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case intervalPicker:
            intervalTextField.text = intervals[row]
            defaults.set(intervals[row], forKey: "Interval")
            intervalTextField.resignFirstResponder()
        case outputSizePicker:
            outputSizeTextField.text = outputSizes[row]
            defaults.set(outputSizes[row], forKey: "OutputSize")
            outputSizeTextField.resignFirstResponder()
        default:
            return
        }
    }
    
}
