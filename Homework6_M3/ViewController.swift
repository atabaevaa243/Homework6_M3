//
//  ViewController.swift
//  Homework6_M3
//
//  Created by mac on 13/1/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alertButton: UIButton!

    @IBOutlet weak var addressSearchBar: UISearchBar!
    
    @IBOutlet weak var addressTableView: UITableView!
    
    var adresses: [String] = ["Ибраимова 37", "Московская 137", "Загорская 44", "Масалиева 43", "Айтматова 76", "6 мкр, 18 дом", "Московская 191", "Карасаева 96", "10 мкр, 32 дом", "Абдрахманова 110"]
    var newAddresses: [String] = []
    var emptyArray: [String] = []
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addressTableView.register(UITableViewCell.self, forCellReuseIdentifier: "address_cell")
        addressTableView.dataSource = self
        alertButton.addTarget(self, action: #selector(alertButtonTap), for: .touchUpInside)
    }
    
    
    @objc func alertButtonTap() {
        for _ in emptyArray{
            var sum = Int.random(in: 100...300)
            total += sum
        }
        let alert = UIAlertController(title: "Стоимость", message: "Итого к оплате: \(total)", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "OK", style: .cancel) {
            action in
        }
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "address_cell", for: indexPath)
        cell.textLabel?.text = newAddresses[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Новый адрес", message: "Вы хотите добавить новый адрес?", preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(title: "Да", style: .cancel)
        {
            action in
            self.emptyArray.append(self.newAddresses[indexPath.row])
            self.addressTableView.reloadData()
        }
       
        
        let cancelAction = UIAlertAction(title: "Нет", style: .default)
        {
            action in
        }
                
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        newAddresses = []
        
        if searchText == "" {
            newAddresses = emptyArray
        } else {
            for address in adresses {
                if address.uppercased().contains(searchText.uppercased()) {
                    newAddresses.append(address)
                }
            }
        }
        addressTableView.reloadData()
    }
}
