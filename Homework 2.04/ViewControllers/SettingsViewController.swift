//
//  SettingsViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 24.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redSliderLabel: UILabel!
    @IBOutlet var greenSliderLabel: UILabel!
    @IBOutlet var blueSliderLabel: UILabel!
    
    @IBOutlet var redSliderTF: UITextField!
    @IBOutlet var greenSliderTF: UITextField!
    @IBOutlet var blueSliderTF: UITextField!
    
    // MARK: - Public Properties
    var color: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
        
        colorView.layer.cornerRadius = 20
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redSliderLabel)
            setValue(for: redSliderTF)
        case greenSlider:
            setValue(for: greenSliderLabel)
            setValue(for: greenSliderTF)
        default:
            setValue(for: blueSliderLabel)
            setValue(for: blueSliderTF)
        }
        
        setColor()
    }
    
    @IBAction func donePressed() {
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for sliders: UISlider...) {
        let ciColor = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redSliderLabel: label.text = string(from: redSlider)
            case greenSliderLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redSliderTF: textField.text = string(from: redSlider)
            case greenSliderTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func updateUI() {
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redSliderLabel, greenSliderLabel, blueSliderLabel)
        setValue(for: redSliderTF, greenSliderTF, blueSliderTF)
        setColor()
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            switch textField {
            case self.redSliderTF: self.setValue(for: self.redSliderTF)
            case self.greenSliderTF: self.setValue(for: self.greenSliderTF)
            default: self.setValue(for: self.blueSliderTF)
            }
            textField?.becomeFirstResponder()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
            return
        }
        
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redSliderTF:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redSliderLabel)
        case greenSliderTF:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenSliderLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueSliderLabel)
        }
        
        setColor()
    }
}
