//
//  searchPageVC.swift
//  AlamofireRequest
//
//  Created by Dilara on 14.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class searchPageVC: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewSearching: UITableView!
    
    var arr_movies = [String]()
    var arr_id = [String]()
    var filteredMovies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSearching.dataSource = self
        tableViewSearching.delegate = self
        searchBar.delegate = self
        
        print("you came search page")
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnBackAct(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func getSearchingMovies(queryName:String){
        
        //https://api.themoviedb.org/3/search/movie?query=Avengers&api_key=8e41e93dd5dac9669ceb8d7fb3c663e1
        
        let baseurl = "http://api.themoviedb.org/3/"
        let url = baseurl + "search/movie"
        //let apiKey = "8e41e93dd5dac9669ceb8d7fb3c663e1"
        let query = queryName //get this from search bar after write 2 char
        let param = ["query": query ,"api_key": ServiceConfig.API_KEY]
        
        
        
        AF.request(url, method: .get, parameters: param).responseJSON{ (response) in
            
            switch response.result {
                case .success(let data):
                    print("success")
                    
                    let value = JSON(data)
                    print("output value: \(value)")
                    let resultArray = value["results"]
                    
                    self.arr_movies.removeAll()
                    self.arr_id.removeAll()
                    
                    for i in resultArray.arrayValue {
                        let movieName = i["title"].stringValue
                        self.arr_movies.append(movieName)
                        
                        let movieId = i["id"].stringValue
                        self.arr_id.append(movieId)
                    }
                    
                    self.tableViewSearching.reloadData()
                    
                    
                case .failure(let error):
                    print("error found \(error)")
            }
            
        }
        
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearching.dequeueReusableCell(withIdentifier: "mycelltbc")!
        
        cell.textLabel?.text = arr_movies[indexPath.row]
        //cell.textLabel?.text =
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_movies.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goToDetailPage = Storyboards.main.instantiateViewController(withIdentifier: "detailScreenVC") as! detailScreenVC
        goToDetailPage.movieID = arr_id[indexPath.row]
        self.navigationController?.pushViewController(goToDetailPage, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        print("you wrote: \(searchText)")
        
        if searchText.count >= 2 {
            getSearchingMovies(queryName: searchText)
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
