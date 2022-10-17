//
//  UIApplication+Extension.swift
//  FZWeather
//
//  Created by Fauad Anwar on 17/10/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
