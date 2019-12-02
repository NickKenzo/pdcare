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
    var numbers = [0, 0.5, 1, 0.5, 0, 0.5, 1, 0.5, 0, 0.5]
    
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
        line1.drawValuesEnabled = false
        line1.lineWidth = 2
        line1.circleRadius = 5
        line1.fillAlpha = 1
        line1.setColor(.black)
        line1.setCircleColor(.black)
        line1.drawFilledEnabled = true
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        line1.fill = Fill(linearGradient: gradient, angle: 90)
        line1.drawCircleHoleEnabled = false
        line1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.graphView.leftAxis.axisMinimum)
        }

        let data = LineChartData()
        data.addDataSet(line1)

        graphView.data = data
        
        let xAxis = graphView.xAxis
        xAxis.enabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        
        let yAxis = graphView.leftAxis
        yAxis.enabled = true
        yAxis.labelFont = .systemFont(ofSize: 16)
        
        graphView.rightAxis.enabled = false
    }
}
