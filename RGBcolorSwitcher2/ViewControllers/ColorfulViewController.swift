//
//  colorfulViewController.swift
//  RGBcolorSwitcher2
//
//  Created by Даниил Козлов on 28.08.2023.
//

import UIKit
import Foundation

protocol SettingsViewControllerDelegate: AnyObject {
    func setColorForBigView(with color: UIColor)
}

class ColorfulViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.initialBackgroundColor = view.backgroundColor
        
    }
    
    
    
}

extension ColorfulViewController: SettingsViewControllerDelegate {
    func setColorForBigView(with color: UIColor) {
        view.backgroundColor = color
    }
    
}
