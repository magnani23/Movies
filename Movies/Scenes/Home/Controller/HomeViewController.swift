//
//  HomeViewController.swift
//  Movies
//
//  Created by Victor Magnani on 15/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeTableView = UITableView()
    var moviesResult: MoviesModel?
    
    override func viewDidLoad() {
        self.fetchMovies()

    }
    override func loadView() {
        super.loadView()
        self.title = "Home"
        self.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeCell")
        self.homeTableView.dataSource = self
        self.homeTableView.delegate   = self
    }
    
    private func prepareLayout() {
        view.addSubview(homeTableView)
        self.setTableViewConstraints()
        self.homeTableView.removeExtraCellLines()
    }
    
    private func setTableViewConstraints() {
        self.homeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.homeTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.homeTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.homeTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func fetchMovies() {
        Service.loadMovies { (moviesResult) in
            self.moviesResult = moviesResult
            self.prepareLayout()
            self.homeTableView.reloadData()
        } onError: { (error) in
            print(error)
        }
    }
}



//MARK: - DataSource and Delegate

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesResult?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        if let moviesList = moviesResult?.results[indexPath.row] {
            cell.prepare(movie: moviesList)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MoviesViewController(movie: (moviesResult?.results[indexPath.row])!)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UITableView {
    func removeExtraCellLines() {
        tableFooterView = UIView(frame: .zero)
    }
}

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



