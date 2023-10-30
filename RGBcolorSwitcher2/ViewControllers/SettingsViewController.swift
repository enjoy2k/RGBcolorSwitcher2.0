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
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        
        mainView.backgroundColor = viewColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGest))
        view.addGestureRecognizer(tapGestureRecognizer)
        
//        Здесь нужно реализовать метод, который устанавливает слайдеры согласно цвету на мэйнВью
        
        setValueL(for: redLabel, greenLabel, blueLabel)
        setValueT(for: redTF, greenTF, blueTF)
        
    }
    
    @objc private func tapGest() {
        view.endEditing(true)
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            setValueL(for: redLabel)
            setValueT(for: redTF)
        case greenSlider:
            setValueL(for: greenLabel)
            setValueT(for: greenTF)
        default:
            setValueL(for: blueLabel)
            setValueT(for: blueTF)
        }
    }

    @IBAction func doneButtonPressed() {
        delegate.sendColorBack(with: mainView.backgroundColor ?? UIColor.white)
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
    
    private func setValueL(for labels: UILabel...) {
        labels.forEach { label in
            
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    private func setValueT(for textFields: UITextField...) {
        textFields.forEach { textField in
            
            switch textField {
            case redTF: textField.text = string(from: redSlider)
            case greenTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// MARK: Методы клавы

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(tapGest)
        )
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        
        toolBar.items = [flexibleSpace, doneButton]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return } // Проверил есть ли в ТФе текст
        
        if let currentValue = Float(text) {   // Создаю числовое значение которое передам в поля. Из вышестоящего текста достаю Флот
            
            switch textField {
            case redTF:
                redSlider.setValue(currentValue, animated: true)
                setValueL(for: redLabel)
            case greenTF:
                greenSlider.setValue(currentValue, animated: true)
                setValueL(for: greenLabel)
            default:
                greenSlider.setValue(currentValue, animated: true)
                setValueL(for: blueLabel)
            }
            setColor()
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }

}
