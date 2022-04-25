//
//  String.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

extension String {
    func findURL() -> URL? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        
        guard let range = (detector
            .matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            .compactMap { Range($0.range, in: self) }
            .first) else { return nil }
        
        let string = String(self[range])
        return URL(string: string)
    }
}
