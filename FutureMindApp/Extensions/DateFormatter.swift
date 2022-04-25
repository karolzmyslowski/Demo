//
//  DateFormatter.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

extension DateFormatter {
    
    static let standard: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
