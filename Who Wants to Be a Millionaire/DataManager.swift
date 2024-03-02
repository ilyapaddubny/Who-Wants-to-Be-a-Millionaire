//
//  DataManager.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation



class DataManager {
    func fetchDataOnline(questionsByLevel: QuestionLevel, completion: @escaping (Result<[Question], Error>) -> Void) {
        let levels = QuestionLevel.allCases
        
        // Loop through each question level
        guard let url = URL(string: questionsByLevel.rawValue) else {
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
                print("🔴 \(String(describing: response?.statusCode))")
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let jsonData = data else {
                print("🔴 No data received")
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let response = try? JSONDecoder().decode(HTTPResponse.self, from: jsonData) else {
                print("🔴 Failed to decode questions data")
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            completion(.success(response.results))
            
        }
        task.resume()
    }
}

extension DataManager {
    enum NetworkError: Error {
        case invalidURL, noData, decodingError
    }
}


