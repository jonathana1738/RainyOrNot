//
//  Constants.swift
//  RainyOrNot
//
//  Created by Jonathan on 5/30/17.
//  Copyright © 2017 JProductions. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "ff868496f4d473306617d2a1fde471a1"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.sharedInstance.latitude!)&lon=\(location.sharedInstance.longitude!)&appid=ff868496f4d473306617d2a1fde471a1"

let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.sharedInstance.latitude!)&lon=\(location.sharedInstance.longitude!)&cnt=10&appid=ff868496f4d473306617d2a1fde471a1"



typealias DownloadComplete = () -> () // tells the function when the download is complete


