//
//  MovieModel.swift
//  AlamofireRequest
//
//  Created by Dilara Şimşek on 29.03.2022.
//

import Foundation
import SwiftyJSON


struct FilmModel {
    var id: Int
    var title: String
    var overview: String
    var poster_path: String
    var release_date: String
}

var filmDetailModel:FilmModel!
var allUpComingDetailModel = [FilmModel]()
var allNowPlayingDetailModel = [FilmModel]()



