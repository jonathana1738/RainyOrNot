    //
    //  CurrentWeather.swift
    //  RainyOrNot
    //
    //  Created by Jonathan on 5/30/17.
    //  Copyright © 2017 JProductions. All rights reserved.
    //
    
    import UIKit
    import Alamofire
    
    class CurrentWeather{
        
        private var CCityName: String!
        private var CDate: String!
        private var CWeatherType: String!
        private var CCurrentTemp: Double!
        
        
        
        
        var CityName:String{
            
            if CCityName == nil {
                CCityName = ""
            }
            return CCityName
        }
        
        
        var date:String{
            
            if CDate == nil {
                CDate = ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: Date())
            self.CDate = "Today,\(currentDate)"
            return CDate
        }
        
        
        var WeatherType:String{
            
            if CWeatherType == nil {
                CWeatherType = ""
            }
            return CWeatherType
        }
        
        var CurrentTemp:Double{
            
            if CCurrentTemp == nil {
                CCurrentTemp = 0.0
            }
            return CCurrentTemp
        }
        
        
        func downloadWeatherDetails(completed:  @escaping DownloadComplete){ //DownloadComplete is an alias in the Constants file
            // Tell Alamofire where to download from
            
            Alamofire.request(CURRENT_WEATHER_URL).responseJSON { responce in
                let result = responce.result
                
                // get the JSON Data and store it in a local dictionary
                if let dictionary = result.value as? Dictionary<String, AnyObject>{
                    // then we search for the keys that we want
                    
                    //Getting the name
                    if let name = dictionary["name"] as? String{
                        self.CCityName = name.capitalized
                        print(self.CCityName)
                    }
                    
                    if let weather = dictionary["weather"] as? [Dictionary<String,AnyObject>]{
                        
                        if let main = weather[0]["main"] as? String{
                            self.CWeatherType = main.capitalized
                            print(self.CWeatherType)
                        }
                    }
                    
                    if let main = dictionary["main"] as? Dictionary<String, AnyObject> {
                        if let currentTemperature = main["temp"] as? Double {
                            
                            let kelvinToFareinPreDiv = (currentTemperature * (9/5) - 459.67)
                            
                            let kelvinToFar = Double(round(10 * kelvinToFareinPreDiv/10))
                            
                            self.CCurrentTemp = kelvinToFar
                            print(self.CCurrentTemp)
                            
                        }
                    }
                    
                }
                completed()
            }
            
            
        }
    }
