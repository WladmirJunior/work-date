//
//  SaveClientViewController.swift
//  WorkDate
//
//  Created by Wladmir  on 28/04/21.
//

import CoreData
import UIKit

class SaveClientViewController: UIViewController {
    
    enum Constants {
        static let clientNamePlaceHolder = "Nome Cliente"
        static let clientAddressPlaceHolder = "Endereço"
        static let titleClientPlaceHolder = "Título (opcional)"
        static let firstNamePlaceHolder = "Primeiro Nome"
        static let lastNamePlaceHolder = "Último Nome"
        static let emailPlaceHolder = "Email"
        static let mobilePlaceHolder = "Número Celular (opcional)"
        static let officePlaceHolder = "Número Trabalho (opcional)"
    }
    
    @IBOutlet weak var clientName: UITextView!
    @IBOutlet weak var clientAddress: UITextView!
    @IBOutlet weak var titleClient: UITextView!
    @IBOutlet weak var firstName: UITextView!
    @IBOutlet weak var lastName: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var mobileNumer: UITextView!
    @IBOutlet weak var officeNumber: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var clients: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        setTextFieldsDelegate()
        setPlaceHolder()
        setTextColor()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        saveClient(name: clientName.text)
    }
    
    func saveClient(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Client", in: managedContext)!
        
        let client = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // 3
        client.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func setTextFieldsDelegate() {
        clientName.delegate = self
        clientAddress.delegate = self
        titleClient.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        mobileNumer.delegate = self
        officeNumber.delegate = self
    }
    
    private func setPlaceHolder() {
        clientName.text = Constants.clientNamePlaceHolder
        clientAddress.text = Constants.clientAddressPlaceHolder
        titleClient.text = Constants.titleClientPlaceHolder
        firstName.text = Constants.firstNamePlaceHolder
        lastName.text = Constants.lastNamePlaceHolder
        email.text = Constants.emailPlaceHolder
        mobileNumer.text = Constants.mobilePlaceHolder
        officeNumber.text = Constants.officePlaceHolder
    }
    
    private func setTextColor() {
        clientName.textColor = .lightGray
        clientAddress.textColor = .lightGray
        titleClient.textColor = .lightGray
        firstName.textColor = .lightGray
        lastName.textColor = .lightGray
        email.textColor = .lightGray
        mobileNumer.textColor = .lightGray
        officeNumber.textColor = .lightGray
    }
    
    private func isDifferentFromPlaceHolder() -> Bool {
        return clientName.text != Constants.clientNamePlaceHolder &&
            clientAddress.text != Constants.clientAddressPlaceHolder &&
            firstName.text != Constants.firstNamePlaceHolder &&
            lastName.text != Constants.lastNamePlaceHolder &&
            email.text != Constants.emailPlaceHolder
    }
    
    private func isDifferentFromNil() -> Bool {
        return !clientName.text.isEmpty &&
            !clientAddress.text.isEmpty &&
            !firstName.text.isEmpty &&
            !lastName.text.isEmpty &&
            !email.text.isEmpty
    }
}

extension SaveClientViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        if isDifferentFromPlaceHolder() && isDifferentFromNil() {
        if isDifferentFromNil() {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        
        switch textView {
        case clientName:
            textView.text = Constants.clientNamePlaceHolder
        case clientAddress:
            textView.text = Constants.clientAddressPlaceHolder
        case titleClient:
            textView.text = Constants.titleClientPlaceHolder
        case firstName:
            textView.text = Constants.firstNamePlaceHolder
        case lastName:
            textView.text = Constants.lastNamePlaceHolder
        case email:
            textView.text = Constants.emailPlaceHolder
        case mobileNumer:
            textView.text = Constants.mobilePlaceHolder
        case officeNumber:
            textView.text = Constants.officePlaceHolder
        default: break
        }
        
        textView.textColor = UIColor.lightGray
    }
}
