//
//  SettingsViewController.swift
//  RGBcolorSwitcher2
//
//  Created by Даниил Козлов on 23.10.2023.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func sendColorBack(with color: UIColor)
}

class mainPageViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
        
//         Сделать так чтобы слайдеры вставали в нужное положение
    }
}

extension mainPageViewController: SettingsViewControllerDelegate {
    func sendColorBack(with color: UIColor) {
        view.backgroundColor = color
    }
    
    
}
