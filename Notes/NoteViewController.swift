//
//  NoteViewController.swift
//  Notes
//
//  Created by marcelo on 22/12/2020.
//  Copyright © 2020 marcelo. All rights reserved.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    var note: Note!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        note.name = textView.text
        NoteManager.main.save(note: note)
    }
}
