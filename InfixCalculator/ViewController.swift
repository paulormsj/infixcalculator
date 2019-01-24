//
//  ViewController.swift
//  InfixCalculator
//
//  Created by Paulo Junior on 11/01/19.
//  Copyright © 2019 Paulo Junior. All rights reserved.
//

import UIKit

extension String {
    func substring(from: Int, to: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: from)...self.index(self.startIndex, offsetBy: to)])
    }
}

class ViewController: UIViewController {
   
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var display: UITextField!
    
    var calculatorService: CalculatorService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let calc = try? CalculatorService() else { return }
        calculatorService = calc
    }

    @IBAction func input(_ sender: UIButton) {
        var expression = self.display.text ?? ""
        expression += (sender.titleLabel?.text)! 
        self.display.text = expression
        if self.calculatorService?.evaluateExpression(expression.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) == true {
            alert.isHidden = true
            return
        }else {
            alert.isHidden = false
        }
        
    }
    
}

