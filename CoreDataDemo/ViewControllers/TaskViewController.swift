//
//  TaskViewController.swift
//  CoreDataDemo
//
//  Created by Александр on 4.10.21.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    
    var delegate: TaskViewControllerDelegate?
    
    private let context = StorageManager.shared.persistentContainer.viewContext
    
    private lazy var newTaskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton = setupButton(
        title: "Save",
        color: UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 1),
        action: #selector(save)
    )
    
    private lazy var cancelButton = setupButton(
        title: "Cancel",
        color: UIColor(
            red: 239/255,
            green: 89/255,
            blue: 49/255,
            alpha: 1),
        action: #selector(cancel)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews(newTaskTextField, saveButton, cancelButton)
        setNewTaskTextFieldConstraints()
        setSaveButtonConstraints()
        setCancelButtonConstraints()
    }
    
    // Размещаю элементы интерфейса на View
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func setNewTaskTextFieldConstraints() {
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newTaskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            newTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            newTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setSaveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setCancelButtonConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    @objc private func save() {
        // Прежде чем создать экземпляр модели, создаём описание сущности
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        guard newTaskTextField.text?.isEmpty == false else { return }
        task.title = newTaskTextField.text
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        delegate?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
