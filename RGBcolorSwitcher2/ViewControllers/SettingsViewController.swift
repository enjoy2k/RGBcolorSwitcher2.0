//
//  ViewController.swift
//  RGBcolorSwitcher2
//
//  Created by Евгения Максимова on 12.06.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        
        mainView.backgroundColor = viewColor
        
//        setColor()
        
        setValue(for: redLabel, greenLabel, blueLabel)
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
    }

    @IBAction func doneButtonPressed() {
        
//        На экан настроек цвет передаётся через Сигвей - prepare.
//        А обратно, по нажатии done - делегируя.

    }
    
    private func setColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for slider: UISlider) {
        let newValues = String(from: slider)
        
            switch slider {
            case redSlider:
                redLabel.text = string(from: newValues)
                redTF.text = string(from: newValues)
            case greenSlider:
                greenLabel.text = string(from: newValues)
                greenTF.text = string(from: newValues)
            default:
                blueLabel.text = string(from: newValues)
                blueTF.text = string(from: newValues)
            }
        }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
