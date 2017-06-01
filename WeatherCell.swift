//
//  WeatherCell.swift
//  RainyOrNot
//
//  Created by Jonathan on 5/31/17.
//  Copyright © 2017 JProductions. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var LBLDay: UILabel!
    
    @IBOutlet weak var LBLWeatherType: UILabel!
    @IBOutlet weak var LBLHighTemp: UILabel!
    @IBOutlet weak var LBLLowTemp: UILabel!
    
    func configureCell ( forecast: Forcast) {
        
        LBLLowTemp.text = "\(forecast.lowTemp)"
        LBLHighTemp.text = "\(forecast.highTemp)"
        LBLWeatherType.text = forecast.weatherType
        LBLDay.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }
    
    
    
  
    
}
