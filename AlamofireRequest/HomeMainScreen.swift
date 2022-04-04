//
//  ViewController.swift
//  AlamofireRequest
//
//  Created by Dilara on 14.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON



class HomeMainScreen: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 414.0, height: 256.0)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allNowPlayingDetailModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "mycvccell", for: indexPath) as! movieCVC
        
        cell.lbltitleCVC.text = allNowPlayingDetailModel[indexPath.row].title
        cell.lblDescCVC.text = allNowPlayingDetailModel[indexPath.row].overview
        
        let gradient = CAGradientLayer()
        gradient.frame = cell.imageviewCVC.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        cell.imageviewCVC.layer.addSublayer(gradient)
        
        let url = URL(string: ServiceConfig.IMAGE_BASE_URL + allNowPlayingDetailModel[indexPath.row].poster_path)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.imageviewCVC.image = UIImage(data: data)
                    cell.imageviewCVC.alpha = 0.7
                    
                }
        }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUpComingDetailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "mycell") as! movieTBC
        cell.lblTitle.text = allUpComingDetailModel[indexPath.row].title
        cell.lblDescription.text = allUpComingDetailModel[indexPath.row].overview
        cell.lblDate.text = allUpComingDetailModel[indexPath.row].release_date
        
        //let url = "https://image.tmdb.org/t/p/w500/"
        let url = URL(string: ServiceConfig.IMAGE_BASE_URL + allUpComingDetailModel[indexPath.row].poster_path)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.imgviewMovie.image = UIImage(data: data)
                }
        }
        }
        
        
        return cell
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailPage = Storyboards.main.instantiateViewController(withIdentifier: "detailScreenVC") as! detailScreenVC
            
            detailPage.movieID = (String)(allUpComingDetailModel[indexPath.row].id)
            self.navigationController?.pushViewController(detailPage, animated: true)
        

        
    }

    
    @IBOutlet weak var movieCollectionView: UICollectionView!



    @IBOutlet weak var movieTableView: UITableView!
    
    
    
    

    @IBAction func btnGoSearchPage(_ sender: UIButton) {
        
        let goToSearchPage = Storyboards.main.instantiateViewController(withIdentifier: "searchPageVC") as! searchPageVC
        
            self.navigationController?.pushViewController(goToSearchPage, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUpcomingMovieDetails()
        getNowPlayingMovieDetails()
        
        searchBar.delegate = self
        self.movieTableView.rowHeight = 150

        
    }
    
    func getUpcomingMovieDetails() {
        NetworkUtil.sendRequest(ServiceConfig.SERVICE_BASE_URL+ServiceConfig.MOVIE_UPCOMING, param: ServiceConfig.PARAM_UPCOMING, completionHandler: { film_detail in
            
                allUpComingDetailModel.removeAll()
                
                for i in film_detail {
                    allUpComingDetailModel.append(
                        FilmModel(id: i.id,
                                title: i.title,
                                overview: i.overview,
                                poster_path: i.poster_path,
                                release_date: i.release_date)
                    )
                }

                self.movieTableView.reloadData()
        })
    }
    
    func getNowPlayingMovieDetails() {
        NetworkUtil.sendRequest(ServiceConfig.SERVICE_BASE_URL+ServiceConfig.MOVIE_NOWPLAYING, param: ServiceConfig.PARAM_NOWPLAYING, completionHandler: { film_detail in
            
                allNowPlayingDetailModel.removeAll()
                
                for i in film_detail {
                    allNowPlayingDetailModel.append(
                        FilmModel(id: i.id,
                                  title: i.title,
                                  overview: i.overview,
                                  poster_path: i.poster_path,
                                  release_date: i.release_date)
                    )
                }
                
                if filmDetailModel != nil {
                    allNowPlayingDetailModel.append(filmDetailModel)
                    
                }
                self.movieCollectionView.reloadData()
        })
    }
}
        



