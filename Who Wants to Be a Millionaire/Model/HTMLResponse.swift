//
//  HTMLResponse.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation

struct HTMLResponse: Codable {
    let responseCode: Int
    let results: [Question]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
