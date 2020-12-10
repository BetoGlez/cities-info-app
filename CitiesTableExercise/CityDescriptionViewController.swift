//
//  CityDescriptionViewController.swift
//  CitiesTableExercise
//
//  Created by Alberto González Hernández on 18/11/20.
//

import UIKit

class CityDescriptionViewController: UIViewController {

    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityDescriptionTV: UITextView!
    
    public var cityName: String = "";
    
    private let NO_DATA_MSG = "No existen datos para mostrar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let cityDetailUserDefault = UserDefaults.standard.string(forKey: cityName)
        let cityDetails = cityDetailUserDefault != nil ? (!cityDetailUserDefault!.isEmpty ? cityDetailUserDefault! : NO_DATA_MSG) : NO_DATA_MSG
        print("Loading data for city: \(cityName) \n \(cityDetails)")
        cityTitleLabel.text = cityName
        cityDescriptionTV.text = cityDetails
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if cityDescriptionTV.text != NO_DATA_MSG {
            print("Saving data...")
            UserDefaults.standard.setValue(cityDescriptionTV.text, forKey: cityName)
        }
    }
}
