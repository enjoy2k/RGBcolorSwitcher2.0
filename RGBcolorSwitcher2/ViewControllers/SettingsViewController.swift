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
    
//    var initialBackgroundColor: UIColor!
    var initialRedValue: Float!
    var initialGreenValue: Float!
    var initialBlueValue: Float!
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        
        //        mainView.backgroundColor = initialBackgroundColor
        redSlider.value = initialRedValue
        greenSlider.value = initialGreenValue
        blueSlider.value = initialBlueValue
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleSpace, doneButton]
        
        redTF.inputAccessoryView = toolBar
        greenTF.inputAccessoryView = toolBar          // Дублируется код. Объединить
        blueTF.inputAccessoryView = toolBar
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        setColor()

        updateLabelsAndTextFields(for: redSlider)
        updateLabelsAndTextFields(for: greenSlider)
        updateLabelsAndTextFields(for: blueSlider)
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        updateLabelsAndTextFields(for: sender)
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorForBigView(with: mainView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
   @objc private func doneButtonTapped() {
         redTF.resignFirstResponder()
    }
//
//    private func addingTollBarToKeyBoardTF(with textFields: UITextField...) {
//        let toolBarr = UIToolbar()
//        textFields.forEach { TF in
//            switch TF {
//            case redTF:
//                redTF.inputAccessoryView =
//            case greenTF:
//                greenTF.inputAccessoryView = toolBarr
//            default:
//                blueTF.inputAccessoryView = toolBarr
//            }
//        }
//    }

    private func setColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func updateLabelsAndTextFields(for slider: UISlider) {
            let valueString = makeCuttedString(from: slider)
            
            switch slider {
            case redSlider:
                redLabel.text = valueString
                redTF.text = valueString
            case greenSlider:
                greenLabel.text = valueString
                greenTF.text = valueString
            default:
                blueLabel.text = valueString
                blueTF.text = valueString
            }
        }
    
    private func makeCuttedString(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Int(newValue) else { return }
        
        if textField == redTF {
            redSlider.value = Float(numberValue)
            redLabel.text = String(newValue)
        } else if textField == greenTF {
            greenSlider.value = Float(numberValue)
            updateLabelsAndTextFields(for: greenSlider)
        } else {
            blueSlider.value = Float(numberValue)
            updateLabelsAndTextFields(for: blueSlider)
        }

    }
}

// скрывать клавиатуру тапом по экрану.
// Снизу добавить тулбар, в него поместить decimalPad, потом к ней добавить кнопку Done
