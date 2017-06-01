//
//  WeatherVC.swift
//  RainyOrNot
//
//  Created by Jonathan on 5/29/17.
//  Copyright © 2017 JProductions. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var LBLDate: UILabel!
    @IBOutlet weak var LBLTemperature: UILabel!
    @IBOutlet weak var LBLCurrentLoc: UILabel!
    @IBOutlet weak var LBLWeatherType: UILabel!
    @IBOutlet weak var IMGCurrentWeatherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forcast!
    var forecastsArray = [Forcast]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        
           }
    // will run before the viewdidload
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            location.sharedInstance.latitude = currentLocation.coordinate.latitude
            location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForcastData {
                    self.updateMainUI()
                }
                
            }

        }else{
            //for the first time use
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    
    
    func downloadForcastData(completed:  @escaping DownloadComplete){
        
        Alamofire.request(FORCAST_URL).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    
                    for obj in list{
                        let forecast = Forcast(weatherDict: obj)
                        self.forecastsArray.append(forecast)
                        print (obj)
                    }
                    self.forecastsArray.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // populating the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            let forcast = forecastsArray[indexPath.row]
            cell.configureCell(forecast: forcast)
            return cell
        } else{
            return WeatherCell()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArray.count    }
    
    func updateMainUI(){
        
        LBLDate.text = currentWeather.date
        LBLTemperature.text =  "\(currentWeather.CurrentTemp)"
        LBLWeatherType.text  = currentWeather.WeatherType
        LBLCurrentLoc.text = currentWeather.CityName
        IMGCurrentWeatherImage.image = UIImage(named: currentWeather.WeatherType)
        
        
    }
    
    
    
    
}

