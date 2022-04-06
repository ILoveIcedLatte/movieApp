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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSearching.dataSource = self
        tableViewSearching.delegate = self
        searchBar.delegate = self

    }
    
    
    @IBAction func btnBackAct(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func getSearchMovieList(queryName: String) {
        NetworkUtil.sendRequestforSearch(ServiceConfig.SERVICE_BASE_URL+ServiceConfig.MOVIE_SEARCH, param: ["query": queryName, "api_key": ServiceConfig.API_KEY], completionHandler: {
            film_detail in
            
            allSearchFilmArr.removeAll()
            
            for i in film_detail {
                allSearchFilmArr.append(FilmSearchModel(title: i.title, id: i.id))
            }
            self.tableViewSearching.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearching.dequeueReusableCell(withIdentifier: "mycelltbc")!
        
        cell.textLabel?.text = allSearchFilmArr[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSearchFilmArr.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goToDetailPage = Storyboards.main.instantiateViewController(withIdentifier: "detailScreenVC") as! detailScreenVC
        goToDetailPage.movieID = String(allSearchFilmArr[indexPath.row].id)
        self.navigationController?.pushViewController(goToDetailPage, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
     
        if searchText.count >= 2 {
            getSearchMovieList(queryName: searchText)
        }
        
    }

}
