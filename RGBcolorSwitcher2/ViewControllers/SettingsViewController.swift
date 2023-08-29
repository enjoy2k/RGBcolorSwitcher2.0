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
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var initialBackgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        
        mainView.backgroundColor = initialBackgroundColor
        
        setColor()
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setTFValues(for: redTF, greenTF, blueTF)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redLabel.text = makeCuttedString(from: redSlider)
            redTF.text = makeCuttedString(from: redSlider)
        case greenSlider:
            greenLabel.text = makeCuttedString(from: greenSlider)
            greenTF.text = makeCuttedString(from: greenSlider)
        default:
            blueLabel.text = makeCuttedString(from: blueSlider)
            blueTF.text = makeCuttedString(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorForBigView(with: mainView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
    private func setColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = makeCuttedString(from: redSlider)
            case greenLabel:
                greenLabel.text = makeCuttedString(from: redSlider)
            default:
                blueLabel.text = makeCuttedString(from: redSlider)
            }
        }
    }
    
    private func setTFValues(for tFs: UITextField...) {
        tFs.forEach { tF in
            switch tF {
            case redTF:
                redTF.text = makeCuttedString(from: redSlider)
            case greenTF:
                greenTF.text = makeCuttedString(from: redSlider)
            default:
                blueTF.text = makeCuttedString(from: redSlider)
            }
        }
    }
    
    private func makeCuttedString(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
