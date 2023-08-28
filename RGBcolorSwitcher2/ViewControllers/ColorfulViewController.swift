//
//  colorfulViewController.swift
//  RGBcolorSwitcher2
//
//  Created by Даниил Козлов on 28.08.2023.
//

import UIKit

class ColorfulViewController: UIViewController {

    @IBOutlet var bigieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.biggieColorView = bigieView
        
        
    }
    
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {}

}
