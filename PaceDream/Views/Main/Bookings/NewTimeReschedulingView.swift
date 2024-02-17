////
//  NewTimeReschedulingView.swift
//  bug-free-goggles
//
//  Created by Mac on 20/05/23.
//

import SwiftUI
import Foundation

class BookingIntervalModel: ObservableObject, Identifiable, Equatable {
    var startDate: Date
    var endDate: Date
    var id: Date { startDate }
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    static func == (lhs: BookingIntervalModel, rhs: BookingIntervalModel) -> Bool {
        lhs.id == rhs.id
    }
}

class NewTimeReschedulViewModel: ObservableObject {
    @Published var selectedIntervalDuration: Int = 4.hourToSeconds
    @Published var selectedInterval: BookingIntervalModel?
    
    var intervals: [BookingIntervalModel] {
        let startDate = Date().startOfDay
        let endDate = Date().endOfDay
        
        var lastDate = startDate
        
        var dates: [Date] = []
        repeat {
            dates.append(lastDate)
            lastDate = lastDate.adjust(.second, offset: 30*60)
        } while lastDate <= endDate
        
        return dates.map({BookingIntervalModel(startDate: $0, endDate: $0.adjust(.second, offset: selectedIntervalDuration))})
    }
}

struct NewTimeReschedulingView: View {
    @EnvironmentObject var calendarManager: CalendarManager
//    @State var selectedInterval: Int = 4.hourToSeconds
    @State private var showIntervalPicker: Bool = false
    
    @StateObject var viewModel = NewTimeReschedulViewModel()
    @Environment(\.dismiss) var dismiss
    private let headerHeight: CGFloat = 160
    private let scrollTopPadding: CGFloat = 160 + 20
    
    var body: some View {
        VStack(spacing: 0) {
            topHeaderView
                .zIndex(1)
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.intervals) { interval in
                        IntervalCellView(interval: interval, isSelected: interval == viewModel.selectedInterval) {
                            withAnimation {
                                viewModel.selectedInterval = interval
                            }
                        }
                    }
                }
                .padding()
                .background(Color(red: 254/255, green: 254/255, blue: 254/255))
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showIntervalPicker) {
            BookingIntervalPickerView(selectedInterval: $viewModel.selectedIntervalDuration)
                .presentationDetents([.height(300)])
        }
    }
    
    private var titleBarView: some View {
        HStack {
            backButton
            Spacer()
            intervalPickerHeader
            Spacer()
            backButton.hidden()
        }
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .frame(width: 35, height: 35, alignment: .center)
        }
        .foregroundColor(.primary)
    }
    
    private var topHeaderView: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleBarView
            
            Text(selectedMonthString)
                .font(.circular(size: 18, weight: .medium))
                .padding(.horizontal)
            
            WeekCalendarView()
                .frame(height: 70)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .environmentObject(calendarManager)
        }
        .background(
            Color(uiColor: UIColor.systemBackground)
                .shadow(color: Color(red: 243/255, green: 243/255, blue: 243/255), radius: 5, y: 10)
                .edgesIgnoringSafeArea(.top)
        )
    }
    
    private var selectedMonthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: calendarManager.selectedDate)
    }
    
    private var intervalPickerHeader: some View {
        Button {
            showIntervalPicker = true
        } label: {
            HStack {
                Text(viewModel.selectedIntervalDuration.timeString(format: .full))
                    .font(.system(.title3, design: .default, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.system(.caption, design: .default, weight: .bold))
                    .rotationEffect(.degrees(showIntervalPicker ? 180 : 0))
                    .animation(.default, value: showIntervalPicker)
            }
            .foregroundColor(.primary)
        }
    }
    
    struct IntervalCellView: View {
        @ObservedObject var interval: BookingIntervalModel
        var isSelected: Bool
        var onSelect: () -> Void
        
        var body: some View {
            Button {
                onSelect()
            } label: {
                Text(intervalString)
                    .font(.circular(size: 17, weight: .medium))
                    .monospacedDigit()
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        ZStack {
                            if isSelected {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.blue.opacity(0.15))
                            }
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
                        }
                    )
            }
        }
        
        private var intervalString: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            
            return "\(formatter.string(from: interval.startDate)) - \(formatter.string(from: interval.endDate))"
        }
    }
}

struct BookingIntervalPickerView: View {
    private let intervals: [Int] = [
        30.minuteToSeconds,
        1.hourToSeconds,
        1.hourToSeconds + 30.minuteToSeconds,
        2.hourToSeconds,
        2.hourToSeconds + 30.minuteToSeconds,
        3.hourToSeconds,
        3.hourToSeconds + 30.minuteToSeconds,
        4.hourToSeconds,
        4.hourToSeconds + 30.minuteToSeconds,
        5.hourToSeconds,
        5.hourToSeconds + 30.minuteToSeconds,
        6.hourToSeconds,
        6.hourToSeconds + 30.minuteToSeconds,
        7.hourToSeconds,
        7.hourToSeconds + 30.minuteToSeconds,
        8.hourToSeconds,
        8.hourToSeconds + 30.minuteToSeconds,
        9.hourToSeconds,
        9.hourToSeconds + 30.minuteToSeconds,
        10.hourToSeconds,
        10.hourToSeconds + 30.minuteToSeconds,
        11.hourToSeconds,
        11.hourToSeconds + 30.minuteToSeconds,
        12.hourToSeconds,
        12.hourToSeconds + 30.minuteToSeconds,
    ]
    
    @Binding var selectedInterval: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                closeButton
                    .hidden()
                Spacer(minLength: 0)
                Text("Stay duration")
                    .font(.system(size: 18, weight: .medium, design: .default))
                Spacer(minLength: 0)
                closeButton
            }
            
            Picker("", selection: $selectedInterval) {
                ForEach(intervals, id: \.self) { interval in
                    Text(interval.timeString())
                }
            }
            .pickerStyle(.wheel)
        }
        .padding()
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .fill(Color.secondary.opacity(0.1))
                .overlay {
                    Image(systemName: "multiply")
                        .font(.system(.headline, design: .rounded, weight: .semibold))
                        .foregroundColor(.primary)
                }
        }
        .frame(width: 35, height: 35)
    }
}

struct NewTimeReschedulingView_Previews: PreviewProvider {
    static var previews: some View {
        NewTimeReschedulingView()
            .environmentObject(CalendarManager.shared)
    }
}

extension Int {
    var hourToSeconds: Int { self*3600 }
    var minuteToSeconds: Int { self*60 }
    
    func timeString(format: DateComponentsFormatter.UnitsStyle = .short) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = format
//        formatter.zeroFormattingBehavior = .pad

        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }
}
