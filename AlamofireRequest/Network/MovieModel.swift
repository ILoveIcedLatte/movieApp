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

struct FilmSimilarModel {
    var title: String
    var poster_path: String
}

struct FilmDetailModel {
    var overview : String
    var title : String
    var poster_path : String
    var vote : Float
    var date : String
}

struct FilmSearchModel {
    var title : String
    var id : Int
}


var allFilmDetails: FilmDetailModel!
var allFilmDetailsModel = [FilmDetailModel]()

var filmDetailModel:FilmModel!
var allUpComingDetailModel = [FilmModel]()
var allNowPlayingDetailModel = [FilmModel]()

var filmSimilarModel: FilmSimilarModel!
var allSimilarFilmArr = [FilmSimilarModel]()

var filmSearchModel: FilmSearchModel!
var allSearchFilmArr = [FilmSearchModel]()

