//
//  Service.swift
//  CodeChallenge
//
//  Created by emile on 01/07/2022.
//

import Foundation
import Combine
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

enum ItemType: String {
    case home, events
    
    var url: String {
        switch self {
        case .home: return "home"
        case .events: return "events"
        }
    }
}

protocol ServiceProtocol {
    func fetch(_ type: ItemType) -> AnyPublisher<DataResponse<[Item], NetworkError>, Never>
}

final class Service {
    static let shared: ServiceProtocol = Service()
    private init() {}
}

extension Service: ServiceProtocol {
    func fetch(_ type: ItemType) -> AnyPublisher<Alamofire.DataResponse<[Item], NetworkError>, Never> {
        let url = URL(string: "https://5d1dae5d3374890014f005d1.mockapi.io/api/v1/\(type.rawValue)")!
        
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: [Item].self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
