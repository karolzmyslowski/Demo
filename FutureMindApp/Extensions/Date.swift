//
//  Date.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

extension Date {
    func asPresentingString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
