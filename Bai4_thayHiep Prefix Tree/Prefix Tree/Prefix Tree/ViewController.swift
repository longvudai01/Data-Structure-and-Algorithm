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
    var test = Trie()
    var autoComplete: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        test.search(word: substring)
        for key in test.allWords {
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
        addWord(textField: txtTextField)
        clearTextField()
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
