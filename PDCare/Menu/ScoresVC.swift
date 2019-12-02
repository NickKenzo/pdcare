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
    @IBOutlet var balanceGraphView: LineChartView!
    @IBOutlet var drawingGraphView: LineChartView!
    @IBOutlet var memoryGraphView: LineChartView!
    
    @IBAction func sToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        DispatchQueue.global(qos: .background).async {
            let balanceNumbers = self.grabUserData(username: defaults.string(forKey:"username")!, gameID: 1)
            let drawingNumbers = self.grabUserData(username: defaults.string(forKey:"username")!, gameID: 2)
            let memoryNumbers = self.grabUserData(username: defaults.string(forKey:"username")!, gameID: 3)

            DispatchQueue.main.async {
                self.updateGraph(graphView: self.balanceGraphView, numbers: balanceNumbers)
                self.updateGraph(graphView: self.drawingGraphView, numbers: drawingNumbers)
                self.updateGraph(graphView: self.memoryGraphView, numbers: memoryNumbers)
            }
        }
        
        balanceGraphView.noDataText = "Chart data loading..."
        balanceGraphView.noDataFont = .systemFont(ofSize: 20)
        drawingGraphView.noDataText = "Chart data loading..."
        drawingGraphView.noDataFont = .systemFont(ofSize: 20)
        memoryGraphView.noDataText = "Chart data loading..."
        memoryGraphView.noDataFont = .systemFont(ofSize: 20)
        
        scrollView.addSubview(balanceGraphView)
        scrollView.addSubview(drawingGraphView)
        scrollView.addSubview(memoryGraphView)
        scrollView.contentSize = CGSize(width: balanceGraphView.frame.size.width, height: 1000)
    }
    
    func updateGraph(graphView: LineChartView!, numbers: [Int]){
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {

            let value = ChartDataEntry(x: Double(i), y: Double(numbers[i]))
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
            return CGFloat(graphView.leftAxis.axisMinimum)
        }

        let data = LineChartData()
        data.addDataSet(line1)

        graphView.data = data
        graphView.legend.enabled = false
        
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
    
    func grabUserData(username: String, gameID: Int) -> [Int] {
        
        var scores: [Int] = []
        
        let initURL = "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname="+username+"&game="+String(gameID)
        let url = URL(string: initURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            let APIdata = String(data: data, encoding: .utf8)!
            
            scores = self.processUserData(userData: APIdata, inputRegex: "score\":\"(\\d+)\"")
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return scores
    }

    func processUserData(userData: String, inputRegex: String) -> [Int] {

        let regex = try! NSRegularExpression(pattern: inputRegex)
        let result = regex.matches(in:userData, range:NSMakeRange(0, userData.utf16.count))
        var array: [Int] = []

        guard result.count != 0 else {
            return array
        }
        for i in 0...result.count - 1 {
            let range = result[i].range(at: 1)
            let output = (userData as NSString).substring(with: range)
            array.append((output as NSString).integerValue)
        }
        
        return array
    }
    
}
