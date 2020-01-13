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
    static func fetchHoroscope(for horoscope: Int, completion: @escaping (Result<[Element], AppError>) -> ()) {
        
        let endpointUrlString = "http://sandipbgt.com/theastrologer/api/horoscope/all/today/"
        
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
                    let episodes = try JSONDecoder().decode([Element].self, from: data)
                    dump(episodes.count)
                    completion(.success(episodes))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
