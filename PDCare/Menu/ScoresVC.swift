//
//  ScoresVC.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This view is currently empty, and a placeholder for Version 3
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/ScoresVC.swift

import UIKit
import Charts

class ScoresVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var graphView: LineChartView!
    
    // Placeholder values for chart for now
    var numbers = [0, 0.5, 1, 0.5, 0, 0.5, 1]
    
    @IBAction func sToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
    }
    
    func updateGraph(){
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {

            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value)
        }

        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Game 1")
        line1.lineWidth = 2
        line1.circleRadius = 5
        line1.fillAlpha = 1
        line1.drawFilledEnabled = true
        line1.fillColor = UIColor(red: 50/255, green: 200/255, blue: 244/255, alpha: 0.25)
        line1.drawCircleHoleEnabled = false
        line1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.graphView.leftAxis.axisMinimum)
        }

        let data = LineChartData()
        data.addDataSet(line1)

        graphView.data = data
        graphView.drawBordersEnabled = false
        graphView.pinchZoomEnabled = false
        
        let xAxis = graphView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        
        let yAxis = graphView.leftAxis
        yAxis.labelPosition = .outsideChart
        yAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        yAxis.drawGridLinesEnabled = true
        yAxis.granularityEnabled = true
        yAxis.yOffset = -9
        yAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
    }

}
