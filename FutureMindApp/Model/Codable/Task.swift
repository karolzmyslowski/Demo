//
//  Task.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

struct Task: Codable {
    let description: String
    let imageUrl: String
    let modificationDate: Date
    let orderId: Int
    let title: String
}

extension Task {
    
    func makeDisplayableTask() -> DisplayableTask {
        DisplayableTask(
            cellDescription: description,
            firstSubTitle: title,
            secoundSubTitle: modificationDate.asPresentingString(),
            imageUrl: URL(string: imageUrl)
        )
    }
}
