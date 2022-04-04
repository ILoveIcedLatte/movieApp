//
//  ServiceConfig.swift
//  AlamofireRequest
//
//  Created by Dilara on 15.03.2022.
//

import Foundation


public class ServiceConfig {
    
    public static var API_KEY = "8e41e93dd5dac9669ceb8d7fb3c663e1"
    
    public static var PARAM_UPCOMING = ["api_key" : ServiceConfig.API_KEY]
    public static var PARAM_NOWPLAYING = ["api_key" : ServiceConfig.API_KEY]
    
    public static var SERVICE_BASE_URL = "http://api.themoviedb.org/3/"
    public static var IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
    public static var MOVIE_UPCOMING = "movie/upcoming"
    public static var MOVIE_NOWPLAYING = "movie/now_playing"
    
    public static var MOVIE_DETAILS = "movie/"
    public static var MOVIE_SIMILAR = "/similar"
    
    
    
}
