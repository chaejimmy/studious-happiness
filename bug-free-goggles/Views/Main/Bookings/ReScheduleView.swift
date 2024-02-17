////
//  ReScheduleView.swift
//  bug-free-goggles
//
//  Created by Mac on 13/05/23.
//

import SwiftUI

struct ReScheduleView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var calendarManager: CalendarManager
    @State private var showFullCalendar: Bool = false
    
    var body: some View {
        VStack {
            headerView
                .padding(.horizontal)
            
            WeekCalendarView()
                .frame(height: 70)
                .padding(.horizontal)
                .environmentObject(calendarManager)
            
            TimeReschedulingView()
            
            VStack(alignment: .leading, spacing: 35) {
                dragTextView
                bottomButtonView
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .navigationBarHidden(true)
        .sheet(isPresented: $showFullCalendar) {
            MonthCalendarView()
                .presentationDetents([.height(370)])
                .environmentObject(calendarManager)
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 12) {
            Button {
                dismiss()
            } label: {
                Image("backIcon")
            }
            
            Button {
                showFullCalendar = true
            } label: {
                HStack(spacing: 8) {
                    Text(selectedDateString)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                    
                    Image("arrow_down")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16, alignment: .center)
                }
                .foregroundColor(Color(red: 0.153, green: 0.176, blue: 0.216))
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Circle()
                    .fill(Color(red: 0.949, green: 0.949, blue: 0.969))
                    .frame(width: 40, height: 40, alignment: .center)
                    .overlay {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                    }
            }
        }
    }
    
    private var selectedDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: calendarManager.selectedDate)
    }
    
    private var dragTextView: some View {
        Text("To edit just drag the square at desired time.")
            .font(.system(size: 13, weight: .medium, design: .rounded))
            .padding([.top, .bottom], 2)
            .padding([.leading, .trailing], 8)
            .background {
                Capsule()
                    .fill(Color(red: 0.969, green: 0.969, blue: 0.973))
            }
    }
    
    
    
    private var bottomButtonView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .padding([.top, .bottom], 14)
                    .padding([.leading, .trailing], 20)
                    .background {
                        Capsule()
                            .fill(Color(red: 0.949, green: 0.949, blue: 0.969))
                            .frame(height: 50)
                    }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Submit a New Proposal")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 14)
                    .padding([.leading, .trailing], 32)
                    .background {
                        Capsule()
                            .fill(Color(red: 0, green: 0.341, blue: 1))
                            .frame(height: 50)
                    }
            }

        }
        .frame(maxWidth: .infinity)
    }
}

struct ReScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ReScheduleView()
    }
}
