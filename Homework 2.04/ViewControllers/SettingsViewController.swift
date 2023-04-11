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
    var color: Color!
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 20
        
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
        
        setColor()
        setSliders()
        setLabels()
        setTextFields()
        
        addDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            color.redValue = redSlider.value
        case greenSlider:
            color.greenValue = greenSlider.value
        default:
            color.blueValue = blueSlider.value
        }
        
        setColor()
        setLabels()
        setTextFields()
    }
    
    @IBAction func donePressed() {
        delegate.setValue(for: Color(
            redValue: redSlider.value,
            greenValue: greenSlider.value,
            blueValue: blueSlider.value
        )
        )
        dismiss(animated: true)
    }
    
    // MARK: - Actions
    @objc func doneKeyboardPressed() {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func string(from value: Float) -> String {
        String(format: "%.2f", value)
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(color.redValue),
            green: CGFloat(color.greenValue),
            blue: CGFloat(color.blueValue),
            alpha: 1
        )
    }
    
    private func setSliders() {
        redSlider.value = color.redValue
        greenSlider.value = color.greenValue
        blueSlider.value = color.blueValue
    }
    
    private func setLabels() {
        redSliderLabel.text = string(from: color.redValue)
        greenSliderLabel.text = string(from: color.greenValue)
        blueSliderLabel.text = string(from: color.blueValue)
    }
    
    private func setTextFields() {
        redSliderTF.text = string(from: color.redValue)
        greenSliderTF.text = string(from: color.greenValue)
        blueSliderTF.text = string(from: color.blueValue)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text,
              let textRange = Range(range, in: text) else { return false }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
            .replacingOccurrences(of: ",", with: ".")
        
        switch textField {
        case redSliderTF:
            color.redValue = Float(updatedText) ?? redSlider.value
        case greenSliderTF:
            color.greenValue = Float(updatedText) ?? greenSlider.value
        default:
            color.blueValue = Float(updatedText) ?? blueSlider.value
        }
        
        setColor()
        setSliders()
        setLabels()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
