//
//  ChartViewModel.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/16/25.
//

import Foundation

class ChartViewModel: ObservableObject {
    
    var mockWeekChartData = [
        DailyStepModel(date: Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 9876),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 9239),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 3876),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 5459),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 4398),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 8940)
    ]
    
    var mockYTDChartData = [
        DailyStepModel(date: Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(), count: 9876),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date(), count: 72339),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(), count: 19876),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date(), count: 29239),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -5, to: Date()) ?? Date(), count: 49876),
        DailyStepModel(date: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(), count: 59239),
    ]
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var mockThreeMonthData = [DailyStepModel]()
    
    @Published var oneWeekAverage = 2000
    @Published var oneWeekTotal = 4000
    
    @Published var oneMonthAverage = 3000
    @Published var oneMonthTotal = 6000
    
    @Published var threeMonthAverage = 4000
    @Published var threeMonthTotal = 8000
    
    @Published var ytdChartData = [MonthlyStepModel]()
    @Published var ytdAverage = 0
    @Published var ytdTotal = 0
    
    @Published var oneYearChartData = [MonthlyStepModel]()
    @Published var oneYearAverage = 0
    @Published var oneYearTotal = 0
   
    let healthManager = HealthManager.shared
    
    init() {
        
        let mockOneMonth = mockDataForDays(days: 30)
        let mockThereMonths = mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThereMonths
            
        }
        fetchYTDAndOneYearChartData()
    }
    
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 5000...15000)
            let dailyStepData = DailyStepModel(date: currentDate, count: randomStepCount)
            mockData.append(dailyStepData)
            
        }
        return mockData
    }
    
    func fetchYTDAndOneYearChartData() {
        healthManager.fetchYTDAndOneYearChartData { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.ytdChartData = result.ytd
                    self.oneYearChartData = result.oneYear
                    
                    self.ytdTotal = self.ytdChartData.reduce(0, {$0 + $1.count})
                    self.oneYearTotal = self.oneYearChartData.reduce(0, {$0 + $1.count})
                    
                    self.ytdAverage = self.ytdTotal / Calendar.current.component(.month, from: Date())
                    self.oneYearAverage = self.oneYearTotal / 12
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
