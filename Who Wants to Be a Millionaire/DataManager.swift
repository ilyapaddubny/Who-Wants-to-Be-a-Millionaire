//
//  DataManager.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation

enum QuestionLevel: String, CaseIterable {
    case easy = "https://opentdb.com/api.php?amount=5&difficulty=easy&type=multiple"
    case medium = "https://opentdb.com/api.php?amount=5&difficulty=medium&type=multiple"
    case hard = "https://opentdb.com/api.php?amount=5&difficulty=hard&type=multiple"
    
}

class DataManager {
    var questionsByLevel: [QuestionLevel: [Question]] = [:]
    var completedCalls = 0
    
    func fetchDataOnline(completion: @escaping (Result<[QuestionLevel: [Question]], Error>) -> Void) {
        let levels = QuestionLevel.allCases
        
        // Loop through each question level
        for level in levels {
            guard let url = URL(string: level.rawValue) else {
                print("🔴 invalidURL")
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("🔴 \(error.localizedDescription)")
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    let response = response as? HTTPURLResponse
                    print("🔴 \(response?.statusCode)")
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                guard let jsonData = data else {
                    print("🔴 No data received")
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                guard let response = try? JSONDecoder().decode(HTMLResponse.self, from: jsonData) else {
                    print("🔴 Failed to decode questions data")
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                
                self.questionsByLevel[level] = response.results
                self.completedCalls += 1
                
                // Check if all API calls have completed
                if self.completedCalls == levels.count {
                    completion(.success(self.questionsByLevel))
                }
            }
            
            task.resume()
        }
    }
}

extension DataManager {
    enum NetworkError: Error {
        case invalidURL, noData, decodingError
    }
}


