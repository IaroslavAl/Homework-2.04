//
//  SettingsViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 24.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
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
    
    // MARK: - Properties
    var color: UIColor!
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
        
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
        
        addDoneButton()
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redSliderLabel.text = string(from: redSlider)
            redSliderTF.text = string(from: redSlider)
        case greenSlider:
            greenSliderLabel.text = string(from: greenSlider)
            greenSliderTF.text = string(from: greenSlider)
        default:
            blueSliderLabel.text = string(from: blueSlider)
            blueSliderTF.text = string(from: blueSlider)
        }
        
        setColor()
    }
    
    @IBAction func donePressed() {
        delegate.setValue(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // MARK: - Actions
    @objc func doneKeyboardPressed() {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func getRGBComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (red, green, blue)
    }
    
    private func updateUI() {
        let components = getRGBComponents()
        
        redSlider.value = Float(components.red)
        greenSlider.value = Float(components.green)
        blueSlider.value = Float(components.blue)
        
        redSliderLabel.text = string(from: redSlider)
        greenSliderLabel.text = string(from: greenSlider)
        blueSliderLabel.text = string(from: blueSlider)
        
        redSliderTF.text = string(from: redSlider)
        greenSliderTF.text = string(from: greenSlider)
        blueSliderTF.text = string(from: blueSlider)
        
        setColor()
    }
    
    private func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneKeyboardPressed))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        redSliderTF.inputAccessoryView = toolbar
        greenSliderTF.inputAccessoryView = toolbar
        blueSliderTF.inputAccessoryView = toolbar
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        let updatedText = newValue.replacingOccurrences(of: ",", with: ".")
        
        switch textField {
        case redSliderTF:
            redSlider.value = Float(updatedText) ?? redSlider.value
            redSliderLabel.text = updatedText
        case greenSliderTF:
            greenSlider.value = Float(updatedText) ?? greenSlider.value
            greenSliderLabel.text = updatedText
        default:
            blueSlider.value = Float(updatedText) ?? blueSlider.value
            blueSliderLabel.text = updatedText
        }
        
        setColor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
