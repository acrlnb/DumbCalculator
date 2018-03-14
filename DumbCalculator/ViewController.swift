//
//  ViewController.swift
//  DumbCalculator
//
//  Created by Ana Carolina Barreto on 15/01/18.
//  Copyright © 2018 Ana Carolina Barreto. All rights reserved.
//

// Ao clicar em uma operação, realiza e mostra o resultado
// resetar os numeros para o próximo input

//Não usa textField delegate, experimentação basica com o storyboard

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var inputTxt: UITextField!
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var expressionLbl: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    var inputNumber : Double = 0
    var resultNumber : Double = 0
    
    enum operation {
        case addition
        case subtraction
        case multiplication
        case division
    }
    var operationChosen : operation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedOutside()
    }
    
    //MARK: Actions
    
    @IBAction func clearScreen(_ sender: UIButton) {
        inputTxt.text = nil
    }
    
    @IBAction func resetCalculator(_ sender: UIButton) {
        resultNumber = 0
        inputNumber = 0
        inputTxt.text?.removeAll()
        outputLbl.text?.removeAll()
        expressionLbl.text?.removeAll()
    }
    
    @IBAction func pressAdd(_ sender: UIButton) {
        operationChosen = .addition
        operationManager()
    }
    
    @IBAction func pressSubtract(_ sender: UIButton) {
        operationChosen = .subtraction
        operationManager()
    }
    
    @IBAction func pressMultiply(_ sender: UIButton) {
        operationChosen = .multiplication
        operationManager()


    }
    
    @IBAction func pressDivide(_ sender: UIButton) {
        operationChosen = .division
        operationManager()

    }
    
    @IBAction func calculateResult(_ sender: UIButton) {

        if inputTxt.text != nil {
            updateInput(userInput: &inputNumber)
            calculateOperations(userInput: &inputNumber)
            resultNumber = 0
            inputNumber = 0
        } else {
            print("nil in calculateresult")
            return
        }
    }
    
    func operationManager () {
            updateInput(userInput: &inputNumber)
            calculateOperations(userInput: &inputNumber)
            updateOutput(userInput: &inputNumber)
    }
    
    func updateInput (userInput: inout Double) {
        guard let inputText = inputTxt.text else {
            print ("Invalid inputText")
            return
        }
        userInput = Double(inputText)!
        inputTxt.text?.removeAll()
    }
    
    func calculateOperations(userInput: inout Double) {
        
        if resultNumber == 0 {
            resultNumber = userInput
            expressionLbl.text = String(userInput)
        }
        else {
            expressionLbl.text = expressionLbl.text! + String(userInput)
            switch operationChosen! {
            case .addition:
                resultNumber = resultNumber + userInput
            case .subtraction:
                resultNumber = resultNumber - userInput
            case .multiplication:
                resultNumber = resultNumber * userInput
            case .division:
                resultNumber = resultNumber / userInput
            }
        }
        outputLbl.text = String(resultNumber)
    }
    
    func updateOutput (userInput: inout Double) {
        var operationChar = ""
        
        switch operationChosen! {
        case .addition:
            operationChar = " + "
        case .subtraction:
            operationChar = " - "
        case .multiplication:
           operationChar = " * "
        case .division:
            operationChar = " / "
        }
        expressionLbl.text = expressionLbl.text! + operationChar
    
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedOutside() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


