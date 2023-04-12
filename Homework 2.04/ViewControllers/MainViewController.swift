//
//  MainViewController.swift
//  Homework 2.04
//
//  Created by Iaroslav Beldin on 11.04.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setValue(for color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setValue(for color: UIColor) {
        self.view.backgroundColor = color
    }
}
