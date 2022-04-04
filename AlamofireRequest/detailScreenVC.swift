//
//  detailScreenVC.swift
//  AlamofireRequest
//
//  Created by Dilara on 14.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailScreenVC: UIViewController {
    @IBOutlet weak var lblDateofMovie: UILabel!
    
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var collectionViewSimilar: UICollectionView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgViewMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitleName: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    
    var movieID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        getMovieDetail()
        getSimilarMoviesList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnBackAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getSimilarMoviesList(){
        NetworkUtil.sendRequestforSimilar(ServiceConfig.SERVICE_BASE_URL+ServiceConfig.MOVIE_DETAILS+movieID+ServiceConfig.MOVIE_SIMILAR, param: ServiceConfig.PARAM_NOWPLAYING, completionHandler: { film_detail in
            
            allSimilarFilmArr.removeAll()
            
            for i in film_detail {
                allSimilarFilmArr.append(
                    FilmSimilarModel(title: i.title,
                                     poster_path: i.poster_path)
                )
            }
            
            self.collectionViewSimilar.reloadData()
            
        })
    }
    
    
    func getMovieDetail() {
        NetworkUtil.sendRequestforDetail(ServiceConfig.SERVICE_BASE_URL+ServiceConfig.MOVIE_DETAILS+movieID, param: ServiceConfig.PARAM_NOWPLAYING, completionHandler: { film_detail in
            
            allFilmDetails = FilmDetailModel(overview: film_detail.overview, title: film_detail.original_title, poster_path: film_detail.poster_path, vote: film_detail.vote_average, date: film_detail.release_date)
            
            self.lblMovieTitleName.text = allFilmDetails.title
            self.lblMovieDesc.text = allFilmDetails.overview
            self.lblMovieTitle.text = allFilmDetails.title
            self.lblPoint.text = "\(allFilmDetails.vote)"+"/10"
            self.lblDateofMovie.text = allFilmDetails.date
            
            let url = URL(string: ServiceConfig.IMAGE_BASE_URL + allFilmDetails.poster_path)
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: url!) {
                    self.imgViewMoviePoster.image = UIImage(data: data)
                }
            }
            
        })
    }


}


extension detailScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 165)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSimilarFilmArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewSimilar.dequeueReusableCell(withReuseIdentifier: "mycellcvc", for: indexPath) as! movieSimilarCVC
        
        cell.lblSimilar.text = allSimilarFilmArr[indexPath.row].title
        
        let url = URL(string: ServiceConfig.IMAGE_BASE_URL + allSimilarFilmArr[indexPath.row].poster_path)
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!) {
                cell.imgViewSimilar.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
}
