//
//  ClientViewController.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import UIKit

class ClientViewController: UIViewController {
    
    public enum Constants {
        public static let newClientTitle = "Novo cliente"
        public static let newClientSave = "Salvar"
        public static let newClientCancel = "Cancel"
        
        public static let errorTitle = "Erro"
        public static let fillAllFields = "Preencha todos os campos"
        public static let okButton = "Tudo bem"
        
        public static let name = "Nome"
        public static let address = "Endereço"
        public static let phone = "Telefone"
        
        public static let clientListKey = "clients"
        public static let cellIdentifier = "cell"
    }
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var tableView: UITableView!
    var clientList : [ClientEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if let decodedData = UserDefaults.standard.object(forKey: Constants.clientListKey) as? Data {
            if let clients = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [ClientEntity] {
                clientList.removeAll()
                clientList.append(contentsOf: clients)
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addClient(_ sender: Any) {
        let dialog = UIAlertController(title: Constants.newClientTitle, message: "", preferredStyle: .alert)
        
        dialog.addTextField { textField in
            textField.placeholder = Constants.name
        }
        
        dialog.addTextField { textField in
            textField.placeholder = Constants.address
        }
        
        dialog.addTextField { textField in
            textField.placeholder = Constants.phone
        }
        
        dialog.addAction(UIAlertAction(title: Constants.newClientSave, style: .default, handler: { [weak self] action in
            guard let self = self, let textFields = dialog.textFields else { return }
            
            let fillAllFields = textFields.first { $0.text?.isEmpty ?? true }
            
            guard fillAllFields == nil else {
                self.showFillError()
                return
            }
            
            let client = ClientEntity()
            textFields.forEach({ textField in
                switch textField.placeholder {
                case Constants.name: client.name = textField.text ?? ""
                case Constants.address: client.address = textField.text ?? ""
                case Constants.phone: client.phone = textField.text ?? ""
                default: break
                }
            })
            
            self.saveClient(client)
        }))
        
        dialog.addAction(UIAlertAction(title: Constants.newClientCancel, style: .cancel))
        
        present(dialog, animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE
    
    
    private func saveClient(_ client: ClientEntity) {
        clientList.append(client)
        saveInUserDefaults()
        print("Cliente salvo: \(client)")
        tableView.reloadData()
    }
    
    private func saveInUserDefaults() {
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: clientList, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: Constants.clientListKey)
    }
    
    private func showFillError() {
        let alert = UIAlertController(title: Constants.errorTitle, message: Constants.fillAllFields, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
        present(alert, animated: true)
    }
}

extension ClientViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) else {
            return UITableViewCell()
        }
        let client = clientList[indexPath.row]
        cell.textLabel?.text = client.name
        return cell
    }
}

extension ClientViewController: UITableViewDelegate {
    
}
