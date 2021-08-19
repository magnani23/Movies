//
//  Service.swift
//  Movies
//
//  Created by Victor Hugo Bernardino Magnani on 18/08/21.
//

import Foundation

enum MovieError {
    //Detalhando possíveis erros de retorno da API
    case url
    case taskError (error: Error)
    case noReponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class Service {
    
    private static let APIKEY =  "54fdb3ed792cb3dcc5b1aa2c6d87647b"
    private static let basePath = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKEY)"
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
    
    class func loadMovies(onComplete: @escaping (MoviesModel) -> Void, onError: @escaping (MovieError) -> Void) {
        //Método para carregar os carros da API
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            //Método para criar a tarefa de requisição, utilizando closure
            //Data > Informação que o servidor está devolvendo, no caso, JSON
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    //Desenbrulhando o response, tratando ele como uma resposta vinda de URL com protocolo HTTP
                    onError(.noReponse)
                    return
                }
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        guard let data = data else {return}
                        do {
                            let films = try JSONDecoder().decode(MoviesModel.self, from: data)
                            onComplete(films)
                        } catch {
                            print(error.localizedDescription)
                            onError(.invalidJSON)
                        }
                    }
                } else {
                    print("Algum status inválido no servidor!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}
