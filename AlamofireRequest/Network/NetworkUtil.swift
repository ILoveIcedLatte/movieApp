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

let result : String = "results"


/* import Foundation
 
 typealias DoneBlock = ((_ success: Bool) -> Void)
 typealias ParseNSyncBlock = ((_ json: String, _ done: @escaping DoneBlock) -> Void)

 func fetchParseNSyncJson(parseNSyncBlock: @escaping ParseNSyncBlock) {
     if 200 == 200 {
         print("got the json")
         parseNSyncBlock("the json", { success in
             print("success : \(success)")
         })
     }
 }
 func parseNSync(_ json: String, _ done: @escaping DoneBlock) {
     print("Parsed: \(json)")
     done(true)
 }

 fetchParseNSyncJson(parseNSyncBlock: parseNSync)*/



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
    
    
    static func getDecoder(){
        
    }
    
    
    func nowPlayingRequest() {
        

    }
    
    func upcomingRequest() {
        
    }
    
    
    
}

