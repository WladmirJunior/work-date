//
//  JobViewController.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import UIKit

class JobViewController: UIViewController {
    
    public enum Constants {
        public static let newJobTitle = "Novo Trabalho"
        public static let newClientSave = "Salvar"
        public static let newClientCancel = "Cancel"
        
        public static let errorTitle = "Erro"
        public static let fillAllFields = "Preencha todos os campos"
        public static let okButton = "Tudo bem"
        
        public static let jobTitle = "Descrição"
        public static let value = "Valor"
            
        public static let jobListKey = "jobs"
        public static let cellIdentifier = "cell"
    }

    // MARK: - PROPERTIES
    

    @IBOutlet weak var tableView: UITableView!
    var jobList : [JobEntity] = [JobEntity(title: "Tocar violão", value: "R$ 14.5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        saveInUserDefaults()
        
        if let decodedData = UserDefaults.standard.object(forKey: Constants.jobListKey) as? Data {
            if let jobs = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [JobEntity] {
                jobList.removeAll()
                jobList.append(contentsOf: jobs)
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addJob(_ sender: Any) {
        let dialog = UIAlertController(title: Constants.newJobTitle, message: "", preferredStyle: .alert)
        
        dialog.addTextField { textField in
            textField.placeholder = Constants.jobTitle
        }
        
        dialog.addTextField { textField in
            textField.placeholder = Constants.value
        }
        
        dialog.addAction(UIAlertAction(title: Constants.newClientSave, style: .default, handler: { [weak self] action in
            guard let self = self, let textFields = dialog.textFields else { return }
            
            let fillAllFields = textFields.first { $0.text?.isEmpty ?? true }
            
            guard fillAllFields == nil else {
                self.showFillError()
                return
            }
            
            let job = JobEntity()
            textFields.forEach({ textField in
                switch textField.placeholder {
                case Constants.jobTitle: job.title = textField.text ?? ""
                case Constants.value: job.value = textField.text ?? ""
                default: break
                }
            })
            
            self.saveJob(job)
        }))
        
        dialog.addAction(UIAlertAction(title: Constants.newClientCancel, style: .cancel))
        
        present(dialog, animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE
    
    
    private func saveJob(_ job: JobEntity) {
        jobList.append(job)
        saveInUserDefaults()
        print("Trabalho salvo: \(job)")
        tableView.reloadData()
    }
    
    private func saveInUserDefaults() {
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: jobList, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: Constants.jobListKey)
    }
    
    private func showFillError() {
        let alert = UIAlertController(title: Constants.errorTitle, message: Constants.fillAllFields, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
        present(alert, animated: true)
    }
}


extension JobViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) else {
            return UITableViewCell()
        }
        let job = jobList[indexPath.row]
        cell.textLabel?.text = job.title
        return cell
    }
}

extension JobViewController: UITableViewDelegate {
    
}
