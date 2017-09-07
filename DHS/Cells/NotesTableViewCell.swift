//
//  NotesTableViewCell.swift
//  DHS
//
//  Created by Justin Smith on 8/14/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

protocol NotesCellDelegate {
    func notesUpdated(notes: String)
    func noteTextCountNeedsUpdating(notes: String)
}

class NotesTableViewCell: UITableViewCell, UITextViewDelegate, CheckNotesDataDelegate {

    var firstLoad: Bool = true
    var changesMade: Bool = false
    var saveButtonUsed: Bool = false
    
    var originalNotes: String = ""
    
    @IBOutlet weak var notesTextView: RoundedTextView!
    
    var notes: String?
    
    var patient: Patient!
    
    var delegate: NotesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notesTextView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barTintColor = AppearanceController.shared.mainColor.withAlphaComponent(0.8)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .white
        
        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.notesTextView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.notesTextView.resignFirstResponder()
    }
    
    func updateWith(patient: Patient, editable: Bool) {
        updateEditable(editable: editable)
        self.notesTextView.text = patient.notes
    }
    
    func getData() -> String? {
        if let notes = self.notesTextView.text {
            return notes
        } else {
            return nil
        }
    }
        

    func updateEditable(editable: Bool) {
        if !editable {
            self.notesTextView.isEditable = false
            self.notesTextView.backgroundColor = UIColor.myLightGray()
            self.contentView.backgroundColor = UIColor.myLightGray()
        } else {
            self.notesTextView.isEditable = true
            self.notesTextView.backgroundColor = UIColor.white
            self.contentView.backgroundColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let notes = textView.text {
            self.delegate?.notesUpdated(notes: notes)
        }
    }
    
    var textAmount = 50
    var previousRect = CGRect.zero
    
    func textViewDidChange(_ textView: UITextView) {
        var numLinesInTextView: CGFloat = 0
        let numLines = textView.contentSize.height / (textView.font?.lineHeight)!;
        if (numLines != numLinesInTextView){
            numLinesInTextView = numLines
            if let notes = textView.text {
                self.notes = notes
                self.delegate?.noteTextCountNeedsUpdating(notes: notes)
            }
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
