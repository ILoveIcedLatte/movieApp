//
//  NetworkUtil.swift
//  AlamofireRequest
//
//  Created by Dilara Şimşek on 26.03.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Film: Codable {
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var release_date: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overview = "overview"
        case poster_path = "poster_path"
        case release_date = "release_date"
    }
}


struct FilmDetail : Codable {
    var overview : String
    var original_title: String
    var poster_path : String
    var vote_average : Float
    var release_date : String
    
    
    
    enum CodingKeysDetails: String, CodingKey {
        
        case overview = "overview"
        case original_title = "original_title"
        case poster_path_detail = "poster_path"
        case vote_average = "vote_average"
        case release_date_detail = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeysDetails.self)
        overview = try values.decode(String.self, forKey: .overview)
        original_title = try values.decode(String.self, forKey: .original_title)
        poster_path = try values.decode(String.self, forKey: .poster_path_detail)
        vote_average = try values.decode(Float.self, forKey: .vote_average)
        release_date = try values.decode(String.self, forKey: .release_date_detail)
        
    }
    
 
}

let result : String = "results"



public class NetworkUtil {
    
    static func sendRequest(_ url: String, param: [String : String], completionHandler: @escaping ([Film]) -> ())  {
        
        AF.request(url, method: .get, parameters: param).responseJSON { (response) in
            
            switch response.result {
            case .success(let data):

                do {
                    
                    let value = JSON(data)
                    let resultArray = try value[result].rawData()
                    let film_detail = try JSONDecoder().decode([Film].self, from: resultArray)
                    
                    
                    completionHandler(film_detail)

                }
                catch {print(error)}

            case .failure(let error):
                print (error)
            }
        }
    }
    
    
    static func sendRequestforDetail(_ url: String, param: [String : String], completionHandler: @escaping (FilmDetail) -> ())  {
        
        AF.request(url, method: .get, parameters: param).responseJSON { (response) in

            switch response.result {
            case .success(let data):

                do {

                    let film_detail = try JSONDecoder().decode(FilmDetail.self, from: response.data!)
                    
                    completionHandler(film_detail)

                }
                catch {print(error)}

            case .failure(let error):
                print (error)
            }
        }
    }
    
    
    func nowPlayingRequest() {
        

    }
    
    func upcomingRequest() {
        
    }
    
    
    
}

