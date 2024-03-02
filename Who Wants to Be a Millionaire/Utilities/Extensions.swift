//
//  Extensions.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 02.03.2024.
//

import Foundation

extension String {
    var htmlDecoded: String? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            let attributedString = try NSAttributedString(data: data, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error decoding HTML string: \(error)")
            return nil
        }
    }
}

