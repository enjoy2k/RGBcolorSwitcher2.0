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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.initialRedValue = Float(view.backgroundColor?.rgbComponents?.red ?? 0.0)
        settingsVC.initialGreenValue = Float(view.backgroundColor?.rgbComponents?.green ?? 0.0)
        settingsVC.initialBlueValue = Float(view.backgroundColor?.rgbComponents?.blue ?? 0.0)
    }
}


extension ColorfulViewController: SettingsViewControllerDelegate {
    func setColorForBigView(with color: UIColor) {
        view.backgroundColor = color
    }
}

extension UIColor {
    
    var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue)
        }
        return nil
    }
    
}
