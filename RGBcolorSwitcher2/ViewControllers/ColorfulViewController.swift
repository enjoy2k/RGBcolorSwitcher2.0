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
    
    @IBOutlet var bigieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigieView.backgroundColor = UIColor.green
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.mainView.backgroundColor = bigieView.backgroundColor
    }
    
}

extension ColorfulViewController: SettingsViewControllerDelegate {
    func setColorForBigView(with color: UIColor) {
        bigieView.backgroundColor = color
    }
}
