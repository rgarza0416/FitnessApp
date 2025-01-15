//
//  HistoricDataView.swift
//  FitnessApp
//
//  Created by Ricardo Garza on 1/7/25.
//

import SwiftUI
import Charts

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Double
}

enum ChartOptions: String, CaseIterable {
    case oneWeek = "1W"
    case oneMonth = "1M"
    case threeMonth = "3M"
    case yearToDate = "YTD"
    case oneYear = "1Y"
}


class ChartViewModel: ObservableObject {
    
    var mockChartData = [
        DailyStepModel(date: Date(), count: 12345),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), count: 9876),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), count: 9239),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), count: 3876),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), count: 5459),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), count: 4398),
        DailyStepModel(date: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), count: 8940)
    ]
    
    @Published var mockOneMonthData = [DailyStepModel]()
    @Published var mockThreeMonthData = [DailyStepModel]()
   
    
    init() {
        
        var mockOneMonth = mockDataForDays(days: 30)
        var mockThereMonths = mockDataForDays(days: 90)
        DispatchQueue.main.async {
            self.mockOneMonthData = mockOneMonth
            self.mockThreeMonthData = mockThereMonths
            
        }
    }
    
    func mockDataForDays(days: Int) -> [DailyStepModel] {
        var mockData = [DailyStepModel]()
        for day in 0..<days {
            let currentDate = Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
            let randomStepCount = Int.random(in: 5000...15000)
            let dailyStepData = DailyStepModel(date: currentDate, count: Double(randomStepCount))
            mockData.append(dailyStepData)
            
        }
        return mockData
    }
}

struct ChartsView: View {
    @StateObject var viewModel = ChartViewModel()
    @State var selectedChart: ChartOptions = .oneWeek
    
    var body: some View {
        VStack {
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ZStack {
                switch selectedChart {
                case .oneWeek:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day),
                                    y: .value("Steps", data.count))
                        }
                    }
                case .oneMonth:
                    Chart {
                        ForEach(viewModel.mockOneMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day),
                                    y: .value("Steps", data.count))
                        }
                    }
                case .threeMonth:
                    Chart {
                        ForEach(viewModel.mockThreeMonthData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day),
                                    y: .value("Steps", data.count))
                        }
                    }
                case .yearToDate:
                    EmptyView()
                case .oneYear:
                    Chart {
                        ForEach(viewModel.mockChartData) { data in
                            BarMark(x: .value(data.date.formatted(), data.date, unit: .day),
                                    y: .value("Steps", data.count))
                        }
                    }
                }
            }
            .foregroundStyle(.green)
            .frame(maxHeight: 350)
            .padding(.horizontal)
            
            HStack {
                ForEach(ChartOptions.allCases, id: \.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            selectedChart = option
                        }
                    }
                    .padding()
                    .foregroundColor(selectedChart == option ? .white : .green)
                    .background(selectedChart == option ? .green : .clear)
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ChartsView()
}
