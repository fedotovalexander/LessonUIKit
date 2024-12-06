//
//  ViewController.swift
//  LessonUIKit
//
//  Created by Alexander Fedotov on 03.12.2024.
//

import UIKit

final class ViewController: UIViewController {

    // Mark: IB Outlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var textField: UITextField!
    
    // Mark: View Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.insertSegment(withTitle: "Third", at: 2 , animated: false)
        setupSlider()
        setupMainLabel()
    }

    // Mark: IB Actions
    @IBAction func segmentedControlAction() {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                mainLabel.text = "First"
                mainLabel.textColor = .red
            case 1:
                mainLabel.text = "Second"
                mainLabel.textColor = .yellow
            default:
                mainLabel.text = "Third"
                mainLabel.textColor = .green
        }
    }
    
    @IBAction func sliderAction() {
        mainLabel.text = slider.value.formatted()
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(CGFloat(slider.value))
    }
    
    @IBAction func doneButtonAction() {
        guard let inputText = textField.text, !inputText.isEmpty else {
            showAlert(withTitle: "Text field is empty", andMessage: "Please enter your name")
            return
        }
        
        let userNamePattern = "^[a-zA-Z]{3,20}$"
        let isUserNameValid = NSPredicate(format: "SELF MATCHES %@", userNamePattern)
            .evaluate(with: inputText)
        
        if !isUserNameValid {
            showAlert(withTitle: "Wrong format", andMessage: "Please enter your name")
            return
        }
        
        mainLabel.text = inputText
        textField.text = ""
    }

    // Mark: Private Methods
    private func showAlert (withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAcion = UIAlertAction(title: "OK", style: .default) { _ in
            self.textField.text = ""
        }
        alert.addAction(okAcion)
        present(alert, animated: true)
    }
}

// Mark: Setup UI
extension ViewController {
    private func setupMainLabel() {
        mainLabel.text = slider.value.formatted()
        mainLabel.font = .systemFont(ofSize: 35)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 2
    }
    
    private func setupSlider () {
        slider.value = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .green
    }
}

