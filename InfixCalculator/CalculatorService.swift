//
//  CalculatorService.swift
//  InfixCalculator
//
//  Created by Paulo Junior on 24/01/19.
//  Copyright © 2019 Paulo Junior. All rights reserved.
//

import Foundation


class CalculatorService {
    
    let signs = "[*\\-+/]"
    let numbers = "(-?[0-9]+)"
    let parentesis = "\\(.*\\)"
    var infixExpressionBase: String
    var regex: NSRegularExpression
    var parentesisRegex: NSRegularExpression
    
    init() throws {
        infixExpressionBase = "(^\(signs) (\(parentesis)|\(numbers)) (\(parentesis)|\(numbers))$|^\\(\(signs) (\(parentesis)|\(numbers)) (\(parentesis)|\(numbers))\\)$)"
        regex =  try NSRegularExpression(pattern: infixExpressionBase, options: NSRegularExpression.Options.caseInsensitive)
        parentesisRegex = try NSRegularExpression(pattern: parentesis, options: NSRegularExpression.Options.caseInsensitive)
    }
    
    
    func evaluateExpression(_ expression: String) -> Bool {
        return expression.range(of: infixExpressionBase,options: [.regularExpression]) != nil &&
            parentesisRegex.matches(in: expression, options: .withoutAnchoringBounds, range: NSMakeRange(0, expression.count))
                .map { String(expression[Range($0.range, in: expression)!])}
                .reduce(true, { a,b in return a && evaluateExpression(b.substring(from: 1, to: b.count-2)) })
    }
    
}
