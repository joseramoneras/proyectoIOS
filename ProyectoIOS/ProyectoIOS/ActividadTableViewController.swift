//
//  ActividadTableViewController.swift
//  ProyectoIOS
//
//  Created by dam on 31/1/17.
//  Copyright © 2017 dam. All rights reserved.
//

import UIKit
import os.log

class ActividadTableViewController: UITableViewController, RestResponseReceiver, UISearchBarDelegate, UISearchResultsUpdating  {
    var contador: Int = 0
    //MARK: Properties
    var actividades = [Actividad]()
    
    //MARK: uisearch
    let searchController = UISearchController(searchResultsController: nil)
    var filterActividades = [Actividad]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Titulo", "Profesor", "Fecha"]
        tableView.tableHeaderView = searchController.searchBar
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem

        llamadaRest()
        
    }
    
    //MARK: metodos para search
    
    func filterContentForSearchText(_ searchText: String, scope: String) {
        
        switch(scope){
        case "Titulo":
            filterActividades = actividades.filter({ (actividad : Actividad) -> Bool in
                return actividad.nombreActividad.lowercased().contains(searchText.lowercased())
            })
            print("reloading", filterActividades.count)
            tableView.reloadData()
        //return
        case "Profesor":
            filterActividades = actividades.filter({( actividad : Actividad) -> Bool in
                let categoryMatch = (scope == "Profesor") || (actividad.profeActividad?.nombreProfesor == scope)
                return categoryMatch && (actividad.profeActividad?.nombreProfesor.lowercased().contains(searchText.lowercased()))!
                
            })
            tableView.reloadData()
        //return
        case "Fecha":
            filterActividades = actividades.filter({( actividad : Actividad) -> Bool in
                let categoryMatch = (scope == "Fecha") || (actividad.fechaActividad == scope)
                return categoryMatch && actividad.fechaActividad.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        //return
        default:
            return
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }

    //MARK: tableView filter
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterActividades.count
        }
        return actividades.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "ActividadTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as? ActividadTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CeldaActividad.")
        }
        var actividad = Actividad()
        
        if searchController.isActive && searchController.searchBar.text != "" {
            actividad = filterActividades[indexPath.row]
        }
        else {
            actividad = actividades[indexPath.row]
        }
        
        cell.NombreActividad.text = actividad.nombreActividad
        cell.DescripcionCortaActividad.text = actividad.descripcionCorta
        cell.NombreProfesor.text = actividad.profeActividad?.nombreProfesor
        cell.FechaActividad.text = actividad.fechaActividad
        
        if(contador % 2 == 0){
            cell.backgroundColor = #colorLiteral(red: 0.8970833489, green: 0.8862802473, blue: 0.870307739, alpha: 1)
        }else{
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        contador += 1
        return cell
    }

    
    
    //MARK: Acciones
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        /*if let sourceViewController = sender.source as? ActividadViewController, let actividad = sourceViewController.actividad {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                actividades[selectedIndexPath.row] = actividad
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //añadir una nueva actividad
                let newIndexPath = IndexPath(row: actividades.count, section: 0)
                actividades.append(actividad)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }*/
        //self.tableView.reloadData()
        print("lanzo peticion")
        llamadaRest()
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let idBorrar = actividades.remove(at: indexPath.row)
            let datos = ["id": "\(idBorrar.idActividad)"]
            print(datos)
            
            llamadaRestDelete(datos: datos)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: metodos restBorrar
    
    func llamadaRestDelete(datos: [String: Any]) {
        guard let cliente = ClienteRest(target: "actividad", responseObject: self, "DELETE", datos) else {
            return
        }
        print(cliente.request())
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "Add Item":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            guard let navigationController = segue.destination as? UINavigationController, let mealDetailViewController = navigationController.topViewController as? ActividadViewController else {
                fatalError("Las cagao")
            }
            mealDetailViewController.controller = self
            
        case "Show Detail":
            guard let mealDetailViewController = segue.destination as? ActividadViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? ActividadTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let actividadSeleccionada = actividades[indexPath.row]
            mealDetailViewController.actividad  = actividadSeleccionada
            mealDetailViewController.controller = self
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    
    }
    
    //MARK: metodos rest
    
    func llamadaRest() {
        contador = 0
        guard let cliente = ClienteRest(target: "actividad", responseObject: self) else {
            return
        }
        cliente.request()
        
    }
    
    func onDataReceived(data: Data) {
        
        guard let diccionario = RestJsonUtil.jsonToDict(data: data) else {
            print("he entrado en el guard")
            llamadaRest()
            
            return
        }
        //print(diccionario)
        self.actividades = RestJsonUtil.getArrayActividadFromJson(diccionario: diccionario)
        
        //print(actividades.count)
        
        //iniciar(actividades: actividades)
        print("recargando, que pollas")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onErrorReceivingData(message: String) {
        print(message)
    }
    
    /*func iniciar(actividades: [Actividad]){
        
        for actividad in actividades{
            print("\(actividad.nombreActividad)")
            
            let actividad = Actividad.init(nombreActividad: actividad.nombreActividad, fechaActividad: actividad.fechaActividad, lugar: actividad.lugar, horaInicio: actividad.horaInicio, horaFin: actividad.horaFin, descripcion: actividad.descripcion, descripcionCorta: actividad.descripcionCorta, idProfe: actividad.idProfe, nombreProfe: actividad.nombreProfe, idGrupo: actividad.idGrupo, nombreGrupo: actividad.nombreGrupo)
            self.actividades.append(actividad)
            
        }
    }*/
    
    /*func iniciar(){
        for index in 1...50{
            let fecha = "30/05/2016"
            let hora = "20:30"
            //let fecha3 = fecha.addingTimeInterval(60.0*60.0)
            let actividad = Actividad.init(nombreActividad: "nombre \(index)", fechaActividad: fecha, lugar: "sitio", horaInicio: hora, horaFin: hora, descripcion: "moreno", descripcionCorta: "toma", idProfe: index, nombreProfe: "juan", idGrupo: index, nombreGrupo: "1A")
            actividades.append(actividad)
            print (String(describing: fecha))
        }
    }*/
    
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
}
/*extension ActividadTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
extension ActividadTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}*/
