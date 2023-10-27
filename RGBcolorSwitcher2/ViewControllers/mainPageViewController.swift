//
//  SettingsViewController.swift
//  RGBcolorSwitcher2
//
//  Created by Даниил Козлов on 23.10.2023.
//

import UIKit

class mainPageViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.viewColor = view.backgroundColor
    }
}
