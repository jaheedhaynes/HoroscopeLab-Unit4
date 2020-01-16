//
//  APIClient.swift
//  HoroscopeLab-Unit4
//
//  Created by Jaheed Haynes on 1/13/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import Foundation
import NetworkHelper

struct HoroscopeAPI {
    static func fetchHoroscope(for horoscope: String, completion: @escaping (Result<Horoscope, AppError>) -> ()) {
        
        let endpointUrlString = "http://sandipbgt.com/theastrologer/api/horoscope/\(horoscope.lowercased())/today"
        
        guard let url = URL(string: endpointUrlString) else {
            completion(.failure(.badURL(endpointUrlString)))
            return
        }
        
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
                
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                    let sign = try JSONDecoder().decode(Horoscope.self, from: data)
                    completion(.success(sign))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
