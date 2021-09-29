//
//  Service.swift
//  Movies
//
//  Created by Victor Hugo Bernardino Magnani on 18/08/21.
//

import Foundation

enum ErrorCases: Error {
    //Detalhando possíveis erros de retorno da API
    case invalidUrl
    case taskError (error: Error)
    case noReponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class Service {
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess          = false
        //Impedir acesso de dados celulares
        config.httpAdditionalHeaders         = ["Content-Type": "application/json"]
        //Informação do cabeçalho
        config.timeoutIntervalForRequest     = 30
        //Tempo de espera para a execução da requisição
        config.httpMaximumConnectionsPerHost = 20
        //Número máximo de tarefas excutadas durante a requisição, exemplo 5 downloads ao mesmo tempo
        return config
    }()
    
    private static let session = URLSession(configuration: configuration) //URLSession.shared
    
    class func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        guard let url = url else {
            completion(.failure(ErrorCases.invalidUrl))
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(ErrorCases.noData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}

