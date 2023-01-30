//
//  CalendarViewController.swift
//  TechPest
//
//  Created by Monica Barrios on 12/6/22.
//

import UIKit
import Parse

class CalendarViewController: UIViewController, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    var date: DateComponents?
    let calendarView = UICalendarView()
    var logs = [PFObject]()
    var datelogs = [DateComponents()]

    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
        
        date = dateComponents!
        
        self.performSegue(withIdentifier: "NewCalLogSegue", sender: date)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "NewCalLogSegue" {
//            if let nextViewController = segue.destination as? AddLogViewController {
//                nextViewController.day = (date?.day!)!
//                nextViewController.month = (date?.month!)!
//                nextViewController.year = (date?.year!)!
//            }
//        }
//    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

        for logDate in datelogs {
            if(dateComponents.day == logDate.day && dateComponents.month == logDate.month && logDate.year == dateComponents.year){
                return UICalendarView.Decoration.default(color: .systemGreen, size: .large)
            }
        }
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        var query = PFQuery(className:"Pesticide")
        
        query.includeKeys(["author", "application", "location","pesticide","date"])
        let user = PFUser.current()
        
        query.order(byDescending:"createdAt")
        query = query.whereKey("author", equalTo: user!)

        query.limit = 20
        
        query.findObjectsInBackground{ (logs , error) in
            if logs != nil {
                self.logs = logs!
            }
        }

        for log in logs {
            let datestring = (log["date"] as! String).split(separator: " ")
            let month = Int(datestring[0])
            let day = Int(datestring[1])
            let year = Int(datestring[2])

            var logDate = DateComponents()
            logDate.day = day
            logDate.year = year
            logDate.month = month
            
            datelogs.append(logDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCalendar()

    }
    
    func createCalendar(){
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 600),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ]
        )
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
    }
    
}
