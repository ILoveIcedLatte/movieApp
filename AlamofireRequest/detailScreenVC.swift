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
    
    
    var arr_movie_id1 = [String]()
    var arr_movie_title1 = [String]()
    var arr_movie_overview1 = [String]()
    var arr_poster_image1 = [String]()
    var arr_release_date1 = [String]()
    
    var arr_similar_title = [String]()
    var arr_similar_image = [String]()
    
    var movieID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("movieID: \(movieID)")
        
        print("searchid: \(movieID)")
        
        getMovieDetail()
        getSimilarMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnBackAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getSimilarMovies(){
        
        //let baseurl = "http://api.themoviedb.org/3/"
        let url = ServiceConfig.SERVICE_BASE_URL + "movie/\(movieID)/similar"
        //let apiKey = "8e41e93dd5dac9669ceb8d7fb3c663e1"
        let param = ["api_key" : ServiceConfig.API_KEY]
        
        AF.request(url, method: .get, parameters: param).responseJSON { (response) in
            
            print("the similar url: \(url)")
            //print("JSON: \(response)")
            //let upcomingJSON = JSON(response.result.value!)
            //print(upcomingJSON)
            //print("blabla")
            //let getFirst = response[0]["maximum"].stringValue
            //print(getFirst)
            
            switch response.result
            {
             case .success(let data) :
                print("success")
                //print(data)
                let value = JSON(data)
                //print("the similar movies: \(value)")
                
                let resultArray = value["results"]
                
                self.arr_similar_title.removeAll()
                self.arr_similar_image.removeAll()
                
                
                
                for i in resultArray.arrayValue {
                    let movie_title = i["original_title"].stringValue
                    self.arr_similar_title.append(movie_title)
                    let movie_poster = i["poster_path"].stringValue
                    self.arr_similar_image.append(movie_poster)
                }
                
                self.collectionViewSimilar.reloadData()
                
                print("similar titles: \(self.arr_similar_title)")
                
                
                /*
                let url = URL(string: "https://image.tmdb.org/t/p/w500/" + resultPoster)
                DispatchQueue.main.async {
                    if let data = try? Data(contentsOf: url!) {
                        self.imgViewMoviePoster.image = UIImage(data: data)
                    }
                }
                
                */
                
                
                
                
                //let resultdata = value["results"]
                //print(value)
                //print("resultdata: \(resultdata)")
                //let resultArray = value["results"]
                
                //self.arr_movie_id1.removeAll()
                //self.arr_movie_title1.removeAll()
                //self.arr_movie_overview1.removeAll()
                //self.arr_poster_image1.removeAll()
                //self.arr_release_date1.removeAll()
                
                
                /*
                for i in resultArray.arrayValue {
                    //print(i)
                    
                    let movie_id = i["id"].stringValue
                    self.arr_movie_id1.append(movie_id)
                    
                    let movie_name = i["title"].stringValue
                    self.arr_movie_title1.append(movie_name)
                    
                    let movie_overview = i["overview"].stringValue
                    self.arr_movie_overview1.append(movie_overview)
                    
                    let poster_view = i["poster_path"].stringValue
                    self.arr_poster_image1.append(poster_view)
                    
                    let movie_date = i["release_date"].stringValue
                    self.arr_release_date1.append(movie_date)
                    
                } */
                
                
                print("movie titles: \(self.arr_movie_title1)")
                
                
             case . failure(let error) :
                print("error found \(error)")
            }
            
            
            
            }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension detailScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 165)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_similar_title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewSimilar.dequeueReusableCell(withReuseIdentifier: "mycellcvc", for: indexPath) as! movieSimilarCVC
        
        cell.lblSimilar.text = arr_similar_title[indexPath.row]
        
        let url = URL(string: ServiceConfig.IMAGE_BASE_URL + arr_similar_image[indexPath.row])
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!) {
                cell.imgViewSimilar.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
}
