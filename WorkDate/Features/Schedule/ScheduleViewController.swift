//
//  ScheduleViewController.swift
//  WorkDate
//
//  Created by Wladmir  on 10/04/21.
//

import UIKit

class ScheduleViewController: UIViewController {
    
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
        
        public static let scheduleListKey = "schedule"
        public static let cellIdentifier = "cell"
    }
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var tableView: UITableView!
    var scheduleList : [ScheduleEntity] = [ScheduleEntity(dateLabel: "17/03",
                                                          timeLabel: "7:30",
                                                          clientName: "Aline",
                                                          titleJob: "Aula de violão",
                                                          valueJob: "R$ 75,00"),
                                           ScheduleEntity(dateLabel: "18/03",
                                                          timeLabel: "8:30",
                                                          clientName: "Marcos",
                                                          titleJob: "Aula de violão",
                                                          valueJob: "R$ 75,00"),
                                           ScheduleEntity(dateLabel: "19/03",
                                                          timeLabel: "21:30",
                                                          clientName: "Roberto",
                                                          titleJob: "Aula de música",
                                                          valueJob: "R$ 90,00")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
//        saveInUserDefaults()
        
        if let decodedData = UserDefaults.standard.object(forKey: Constants.scheduleListKey) as? Data {
            if let schedules = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [ScheduleEntity] {
                scheduleList.removeAll()
                scheduleList.append(contentsOf: schedules)
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func addSchedule(_ sender: Any) {
        
    }
    
    // MARK: - PRIVATE
    
    private func saveInUserDefaults() {
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: scheduleList, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: Constants.scheduleListKey)
    }
    
    private func showFillError() {
        let alert = UIAlertController(title: Constants.errorTitle, message: Constants.fillAllFields, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButton, style: .default))
        present(alert, animated: true)
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ScheduleViewCell else {
            return UITableViewCell()
        }
        let schedule = scheduleList[indexPath.row]
        cell.dateLabel.text = schedule.dateLabel
        cell.timeLabel.text = schedule.timeLabel
        cell.clientName.text = schedule.clientName
        cell.titleJob.text = schedule.titleJob
        cell.valueJob.text = schedule.valueJob
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scheduleList.remove(at: indexPath.row)
            saveInUserDefaults()
            tableView.reloadData()
        }
    }
}
