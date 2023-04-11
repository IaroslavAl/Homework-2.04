//
//  ViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 24.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

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
    
    var cololModel: Colo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 20
        
        view.backgroundColor = color2
        
        redSliderLabel.text = string(from: color.redValue)
        greenSliderLabel.text = string(from: color.greenValue)
        blueSliderLabel.text = string(from: color.blueValue)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redSliderLabel.text = string(from: redSlider)
        case greenSlider:
            greenSliderLabel.text = string(from: greenSlider)
        default:
            blueSliderLabel.text = string(from: blueSlider)
        }
    }
    
    
    @IBAction func donePressed() {
//        delegate.setValue(for: Color(
//                redValue: redSlider.value,
//                greenValue: greenSlider.value,
//                blueValue: blueSlider.value
//            ))
        dismiss(animated: true)
    }
    
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
}

