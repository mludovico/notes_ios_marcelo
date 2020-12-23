//
//  ViewController.swift
//  Notes
//
//  Created by marcelo on 22/12/2020.
//  Copyright © 2020 marcelo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBAction func createNote() {
        let _ = NoteManager.main.create()
        reload()
     }
    
    var notes: [Note] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let note = notes[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") {_,_,completion in
            NoteManager.main.delete(note: note)
            self.reload()
            completion(true)
        }
        action.image = UIImage(named: "Trash")
        action.backgroundColor = .red
        return action
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].name
        return cell
    }
    
    func reload() {
        notes = NoteManager.main.getAllNotes()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteShowSegue" {
            if let destination = segue.destination as? NoteViewController {
                destination.note = notes[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}

