import UIKit
import CoreMotion
import Dispatch
import MBCircularProgressBar



class ViewController: UIViewController {
    let backgroundView = UIView()
    
    private let METERS_TO_MILES: Int = 1609
    private let goal: Int = 10000
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var startDate: Date? = nil
    
    var distance: Double! = nil
    var pace: Double! = nil
    var numberOfSteps: Int! = 0
    
    // timers
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed: TimeInterval = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setCurrentDate()
//        self.updateHistory()
//        self.startUpdating()
//        self.startTimer()
//        self.dynamic()
    }

    
    
    private func setCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, d"
        let dateString = formatter.string(from: Date())
//        currentDayLabel.text = dateString
    }
    
    func startTimer() {
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
//        displayPedometerData()
    }
    
    @objc
    func timerAction(timer:Timer){
//        displayPedometerData()
    }
    
    
    func dynamic() {
//        let scrollView = UIScrollView()
//        self.view.addSubview(scrollView)
//        view.backgroundColor = .lightGray
//        self.displayToolbar()
        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//            ])
//
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .fill
//        stackView.spacing = 0
//        stackView.distribution = .fill
//        scrollView.addSubview(stackView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            // Attaching the content's edges to the scroll view's edges
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//
//            // Satisfying size constraints
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//            ])
//
//        // Add arranged subviews:
//        for i in 0...20 {
//            // A simple green view.
//            let greenView = UIView()
//            greenView.backgroundColor = .green
//            stackView.addArrangedSubview(greenView)
//            greenView.translatesAutoresizingMaskIntoConstraints = false
//            // Doesn't have intrinsic content size, so we have to provide the height at least
//            greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
//            // Label (has instrinsic content size)
//            let label = UILabel()
//            label.backgroundColor = .orange
//            label.text = "I'm label \(i)."
//            label.textAlignment = .center
//            stackView.addArrangedSubview(label)
//        }
    }
    
//    func displayToolbar() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        toolbar.center = CGPoint(x: view.frame.width / 2, y: 100)
//        toolbar.backgroundColor = .blue
//
//        let homeBarItem = UIBarButtonItem()
//        let homeImage = UIImage(named: "home")
//        homeBarItem.setBackgroundImage(homeImage, for: .normal, barMetrics: .default)
//        toolbar.setItems([homeBarItem], animated: false)
//
//        self.view.addSubview(toolbar)
//    }
    
}


extension ViewController {
    private func startUpdating() {
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }

    }

    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }

    private func startCountingSteps() {
        pedometer.startUpdates(from: Date().startOfDay) {
            [weak self] pedometerData, error in
            guard let pedData = pedometerData, error == nil else { return }
            
            if let distance = pedData.distance {
                self?.distance = distance.doubleValue
            }
            
            self?.numberOfSteps = pedData.numberOfSteps.intValue
            
            if let avarageActivePace = pedData.currentPace {
                self?.pace = avarageActivePace.doubleValue
            }

//            DispatchQueue.main.async {
//                self?.displayPedometerData()
//            }
        }
    }
    
//    private func displayPedometerData() {
//        self.timeElapsed += timerInterval;
//
//        if let numberOfSteps = self.numberOfSteps {
//            self.currentSteps.text = String(numberOfSteps)
//            self.currentProgress.value = CGFloat(numberOfSteps)
//        }
//
//        if let distance = self.distance {
//            self.distanceLabel.text = String(format: "%.1f miles", distance)
//        }
//
//        if let pace = self.pace {
//            paceLabel.text = String(format: "%02.2f m/s", pace)
//        } else {
//            paceLabel.text = String(format:"%02.2f m/s", 0.0)
//        }
//
//        self.caloriesLabel.text = "\(String(self.calories())) kcal"
//
//        if let distance = self.distance, let pace = self.pace {
//            self.timeLabel.text = self.timeLabelFormat(distance: distance, pace: pace)
//        }
//
//    }
    
    private func miles(meters: Double) -> Double {
        let mile = 0.000621371192
        return meters * mile
    }
    
//    private func calories() -> Int {
//        let caloriesPerStep = 0.05
////        return Int(Double(self.numberOfSteps) * caloriesPerStep)
//    }
    
    func timeLabelFormat(distance: Double, pace: Double) -> String {
        var seconds = Int((distance / pace) + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}

extension ViewController {
//    private func updateHistory() {
//        var date = Date.yesterday
//        updateHistoryItem(date: date, dateLabel: historyItemDate1, stepsLabel: historySteps1, progress: progress1)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate2, stepsLabel: historySteps2, progress: progress2)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate3, stepsLabel: historySteps3, progress: progress3)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate4, stepsLabel: historySteps4, progress: progress4)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate5, stepsLabel: historySteps5, progress: progress5)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate6, stepsLabel: historySteps6, progress: progress6)
//
//        date = date.dayBefore
//        updateHistoryItem(date: date, dateLabel: historyItemDate7, stepsLabel: historySteps7, progress: progress7)
//    }
    
    private func updateHistoryItem(date: Date, dateLabel: UILabel!, stepsLabel: UILabel!, progress: MyProgressView!) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, d"
        dateLabel.text = formatter.string(from: date)
        
        pedometer.queryPedometerData(from: date.startOfDay, to: date.startOfDayAfter) {
            [weak self] pedometerData, error in
            if error != nil {
                let randomValue = Float.random(in: 0 ..< 1)
                DispatchQueue.main.async {
                    progress.progress = randomValue
                    stepsLabel.text = "\(Int(randomValue * 10000)) / 10000"
                }
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    progress.progress = Float(pedometerData.numberOfSteps.intValue / (self?.goal ?? 10000))
                    stepsLabel.text = "\(pedometerData.numberOfSteps.stringValue) / \(self?.goal ?? 10000)"
                }
            }
        }
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var startOfDayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self.startOfDay)!
    }
    
    var startOfDayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self.startOfDay)!
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
