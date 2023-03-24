//
//  ViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 24.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redSliderIndicator: UILabel!
    @IBOutlet weak var greenSliderIndicator: UILabel!
    @IBOutlet weak var blueSliderIndicator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redSlider.value = 0.5
        greenSlider.value = 0.5
        blueSlider.value = 0.5
        
        colorView.layer.cornerRadius = 20
    }
    
    @IBAction func sliderChanged() {
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        
        redSliderIndicator.text = String(format: "%.2f", redSlider.value)
        greenSliderIndicator.text = String(format: "%.2f", greenSlider.value)
        blueSliderIndicator.text = String(format: "%.2f", blueSlider.value)
        
        colorView.backgroundColor = UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1
        )
    }
    
}

