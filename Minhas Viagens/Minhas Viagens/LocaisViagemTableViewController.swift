//
//  LocaisViagemTableViewController.swift
//  Minhas Viagens
//
//  Created by Lucas on 25/07/21.
//

import UIKit

class LocaisViagemTableViewController: UITableViewController {
    
    var locaisViagens: [ Dictionary<String, String>] = []
    var controleNavegacao = "adicionar"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        controleNavegacao = "adicionar"
        atualizarViagens()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locaisViagens.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viagem = locaisViagens[ indexPath.row ]["local"]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        celula.textLabel?.text = viagem

        // Configure the cell...

        return celula
    }
    
    // remover itens
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ArmazenamentoDados().removerViagens( indice: indexPath.row )
            atualizarViagens()
        }
    }
    
    func atualizarViagens() {
        
        locaisViagens = ArmazenamentoDados().listarViagens()
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.controleNavegacao = "listar"
        performSegue(withIdentifier: "verLocal", sender: indexPath.row )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verLocal" {
            
            let viewDestino = segue.destination as! ViewController
            
            if self.controleNavegacao == "listar" {
                
                if let indiceRecuperado = sender {
                    
                    let indice = indiceRecuperado as! Int
                    viewDestino.viagem = locaisViagens [ indice ]
                    viewDestino.indiceSelecionado = indice
                }
            } else {
                
                viewDestino.viagem = [:]
                viewDestino.indiceSelecionado = -1
                
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
