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
    
    var delegate: SettingsViewControllerDelegate?
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = viewColor
      
        setSliders()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTF, greenTF, blueTF)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            setValue(for: redTF)
            setValue(for: redLabel)
        case greenSlider:
            setValue(for: greenTF)
            setValue(for: greenLabel)
        default:
            setValue(for: blueTF)
            setValue(for: blueLabel)
        }
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorForBigView(with: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}
    
//    MARK: - Private Methods
extension SettingsViewController {
    
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
            case redLabel: label.text = makeCuttedString(from: redSlider)
            case greenLabel: label.text = makeCuttedString(from: greenSlider)
            default: label.text = makeCuttedString(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF: textField.text = makeCuttedString(from: redSlider)
            case greenTF: textField.text = makeCuttedString(from: greenSlider)
            default: textField.text = makeCuttedString(from: blueSlider)
            }
        }
    }
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    
    private func makeCuttedString(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// MARK: - UITextFieldDelegate
    extension SettingsViewController: UITextFieldDelegate {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                switch textField {
                case redTF:
                    redSlider.setValue(currentValue, animated: true)
                    setValue(for: redLabel)
                case greenTF:
                    greenSlider.setValue(currentValue, animated: true)
                    setValue(for: greenLabel)
                default:
                    greenSlider.setValue(currentValue, animated: true)
                    setValue(for: blueLabel)
                }
                setColor()
                return
            }
            
            showAlert(title: "Wrong format!", message: "Please enter correct value")
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            let keyBoardToolBar = UIToolbar()
            keyBoardToolBar.sizeToFit()
            textField.inputAccessoryView = keyBoardToolBar
            
            let doneButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(didTapDone)
                )
            
            let flexibleButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
                )
            
            keyBoardToolBar.items = [flexibleButton, doneButton]
        }
    }


