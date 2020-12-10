//
//  CitiesViewController.swift
//  CitiesTableExercise
//
//  Created by Alberto González Hernández on 18/11/20.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    let ORIGINAL_CITIES: [String] = ["Albacete", "Alicante/Alacant", "Almería", "Araba/Álava", "Asturias", "Ávila", "Badajoz", "Balears, Illes", "Barcelona", "Bizkaia", "Burgos", "Cáceres", "Cádiz", "Cantabria", "Castellón/Castelló", "Ciudad Real", "Córdoba", "Coruña, A", "Cuenca", "Gipuzkoa", "Girona", "Granada", "Guadalajara", "Huelva", "Huesca", "Jaén", "León", "Lleida", "Lugo", "Madrid", "Málaga", "Murcia", "Navarra", "Ourense", "Palencia", "Palmas, Las", "Pontevedra", "Rioja, La", "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia/València", "Valladolid", "Zamora", "Zaragoza", "Ceuta", "Melilla"]
    let CITY_LIST_KEY = "spainCityList"
    
    var spainCityList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Read from storage city list data
        var cityList = UserDefaults.standard.stringArray(forKey: CITY_LIST_KEY)
        if cityList != nil {
            print("Reading city list...")
            spainCityList = cityList!.count > 0 ? cityList! : []
        } else {
            print("Creating city list...")
            saveCityList(cityList: ORIGINAL_CITIES)
            cityList = UserDefaults.standard.stringArray(forKey: CITY_LIST_KEY)
            spainCityList = cityList!.count > 0 ? cityList! : []
        }
    }
    
    @IBAction func addNewCity(_ sender: Any) {
        let alert = UIAlertController(title: "Añadir ciudad", message: "Introduce el nombre de la nueva ciudad",
        preferredStyle: .alert)
        let action = UIAlertAction(title: "Crear", style: .default, handler: { actn in
            let newCity = alert.textFields![0].text!
            self.addNewCityToTable(newCity: newCity)
        })
        alert.addTextField { (userTextField) in
            userTextField.placeholder = "Nombre de la ciudad"
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return spainCityList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = spainCityList[indexPath.row]
        return cell
    }

    // Editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let city = spainCityList.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: city)
            print("Deleting: \(city)")
            saveCityList(cityList: spainCityList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let city = spainCityList.remove(at: fromIndexPath.row)
        spainCityList.insert(city, at: to.row)
        saveCityList(cityList: spainCityList)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.destination.view != nil {
            let pos = tableView.indexPathForSelectedRow!.row
            let cityViewCtrl = segue.destination as! CityDescriptionViewController
            cityViewCtrl.cityName = spainCityList[pos]
        }
    }
    
    // Add a city to the table
    private func addNewCityToTable(newCity: String) {
        if !newCity.isEmpty || spainCityList.contains(newCity) {
            let newIndexPath = IndexPath(row: 0, section: 0)
            spainCityList.insert(newCity, at: 0)
            saveCityList(cityList: spainCityList)
            self.tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    // Save the city list in the storage
    private func saveCityList(cityList: [String]) {
        print("Saving city list...")
        UserDefaults.standard.set(cityList, forKey: CITY_LIST_KEY)
    }

}
