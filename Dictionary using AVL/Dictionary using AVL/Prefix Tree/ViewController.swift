//
//  ViewController.swift
//  Prefix Tree
//
//  Created by Dai Long on 3/14/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtTextField: UITextField!
    @IBOutlet weak var list: UITableView!
    
    //properties
    var avltree = AVLTree(elements: loaddata())
    var test = Trie()
    var autoComplete: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        txtTextField.delegate = self
        list.delegate = self
    }
    
    //After adding a word
    func clearTextField() {
        txtTextField.text = ""
    }
    
    func searchAutocompleteEntriesWithSubstring(_ substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        test.allWords.removeAll()
        let mang = test.search(word: substring)
        for key in mang {
            let myString:NSString! = key as NSString
            let substringRange :NSRange! = myString.range(of: substring)
            if (substringRange.location  == 0) {
                autoComplete.append(key)
            }
        }
        list.reloadData()
    }

    
    func addWord(textField: UITextField) {
        let textToAdd = textField.text ?? ""
        test.insert(word: textToAdd)
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        guard let node = avltree.search(value: txtTextField.text ?? "") else {return}
        print(node)
    }
    
    @IBAction func unwindtoMain (segue: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mainTOdetail") {
            let detailViewController = segue.destination as! DetailViewController
            let node = avltree.search(value: txtTextField.text ?? "")
            detailViewController.nameString = node?.value ?? ""
            detailViewController.detailString = node?.meaning ?? ""
        }
    }
}
extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWithSubstring(substring)
        return true
    }
    
  
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        txtTextField.text = selectedCell.textLabel!.text!
    }
}
