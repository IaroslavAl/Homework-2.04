//
//  MainViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 11.04.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setValue(for color: Color)
}

final class MainViewController: UIViewController {
    
    private var color = Color(redValue: 1, greenValue: 1, blueValue: 1) {
        didSet {
            view.backgroundColor = UIColor(
                red: CGFloat(color.redValue),
                green: CGFloat(color.greenValue),
                blue: CGFloat(color.blueValue),
                alpha: 1
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: CGFloat(color.redValue),
            green: CGFloat(color.greenValue),
            blue: CGFloat(color.blueValue),
            alpha: 1
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        settingsVC.color = color
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setValue(for color: Color) {
        self.color = color
    }
}

