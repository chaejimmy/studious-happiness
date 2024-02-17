import SwiftUI

struct CalendarView: View {
    
    @State private var selectedStartDate: Date?
        @State private var selectedEndDate: Date?
        @State private var displayedMonth = Date()

        private let calendar = Calendar.current
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        }()
    
    private let daySymbols = ["Mo", "Tu", "We", "Th", "Fr", "Sat","Su"]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                                   changeMonth(by: -1) // Decrease month by 1
                               }) {
                                   Image(systemName: "chevron.left")
                                       .foregroundColor(.black)
                                       .font(.system(size: 10))
                               }
                               .buttonStyle(PlainButtonStyle())

                
                if let startDate = selectedStartDate, let endDate = selectedEndDate {
                    Text("\(formattedDate(startDate,0)) - \(formattedDate(endDate,1))")
                        .font(.system(size: 16, weight: .semibold))
                } else {
                    Text("Select Date")
                        .font(.system(size: 16, weight: .bold))
                }
                Button(action: {
                                  changeMonth(by: 1) // Increase month by 1
                              }) {
                                  Image(systemName: "chevron.right")
                                      .foregroundColor(.black)
                                      .font(.system(size: 10))
                              }
                              .buttonStyle(PlainButtonStyle())


                Spacer()
                Button {

                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color("DarkWhite"))
                            .frame(width: 35, height: 35)
                        Image(systemName: "xmark")
                            .foregroundColor(Color("993C3C43"))
                            .font(.system(size: 17, weight: .bold))
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            
        
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                         ForEach(daySymbols, id: \.self) { day in
                             Text(day)
                                 .font(.headline)
                                 .frame(maxWidth: .infinity)
                                 .foregroundColor(Color("DAE0E6"))
                                 .frame(maxWidth: .infinity)

                         }
                         ForEach(calendarDates(), id: \.self) { date in
                             Button(action: {
                                 selectDate(date)
                             }) {
                                 Text(dateFormatter.string(from: date))
                                     .font(.headline)
                                     .padding(.top,11)
                                     .padding(.leading,13)
                                     .padding(.trailing,13)
                                     .padding(.bottom,11)
                                     .foregroundColor(dateForegroundColor(date))
                                     .clipShape(RoundedRectangle(cornerRadius: dateCornerRadius(date)))
                                     .background(dateBackground(date))
                             }
                             .disabled(!isDateInDisplayedMonth(date))
                         }
                     }
                     .padding()
            
            HStack {
                
                Button {
                } label: {
                    HStack(spacing: 10) {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 180)
                .buttonStyle(PrimaryButtonStyle(background: .darkWhite))

                
                Button {

                } label: {
                    HStack(spacing: 10) {
                        
                        Text("Set")
                    }
                }
                .frame(width: 180)

                .buttonStyle(PrimaryButtonStyle(background: .black))
            }
            .padding(.trailing)
            
//            TimeView()
        }
    }
    
    
    private func changeMonth(by amount: Int) {
         if let newMonth = calendar.date(byAdding: .month, value: amount, to: displayedMonth) {
             displayedMonth = newMonth
         }
     }

    private func formattedDate(_ date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .long
           dateFormatter.timeStyle = .none
           return dateFormatter.string(from: date)
       }

       private func formattedMonth(_ date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MMMM yyyy"
           return dateFormatter.string(from: date)
       }

       private func calendarDates() -> [Date] {
           let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
           let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
           return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startOfMonth) }
       }

       private func isDateInDisplayedMonth(_ date: Date) -> Bool {
           calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
       }
    
    private func selectDate(_ date: Date) {
            if let start = selectedStartDate, selectedEndDate == nil {
                // Selecting the end date
                if date > start {
                    selectedEndDate = date
                } else {
                    // Swap start and end dates if selected in reverse order
                    selectedStartDate = date
                    selectedEndDate = start
                }
            } else {
                // Selecting the start date or resetting the selection
                selectedStartDate = date
                selectedEndDate = nil
            }
        }
        






    private func dateCornerRadius(_ date: Date) -> CGFloat {
        if let start = selectedStartDate, let end = selectedEndDate {
            if date == start && date == end {
                return 20
            } else if date == start {
                return 20
            } else if date == end {
                return 20
            }
        } else if let start = selectedStartDate {
            if date == start {
                return 20
            }
        }
        
        return 0.0
    }

    private func dateBackground(_ date: Date) -> some View {
        let cornerRadius = dateCornerRadius(date)
        
        if let start = selectedStartDate, let end = selectedEndDate {
            if date == start {
                return RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.appPrimary)
            } else if date == end {
                return RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.appPrimary)
            } else if date > start && date < end {
                return RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color("DarkWhite"))
            }
        }
        
        if let selectedDate = selectedStartDate, selectedEndDate == nil {
            if date == selectedDate {
                return RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.appPrimary)
            }
        }
        
        return RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.clear) // Transparent color for unselected dates
    }





    private func dateForegroundColor(_ date: Date) -> Color {
        if let start = selectedStartDate, let end = selectedEndDate {
            if date == start {
                return Color.white
            } else if date == end {
                return Color.white
            } else if date > start && date < end {
                return Color.black
            }
        } else if let selectedDate = selectedStartDate, selectedEndDate == nil {
            if date == selectedDate {
                return Color.white
            }
        }
        
        // Exclude the current date
        let today = calendar.startOfDay(for: Date())
        if calendar.isDate(date, equalTo: today, toGranularity: .day) {
            return Color.primary // Color for today's date
        } else if date < today {
            return Color.black // Color for dates before today
        } else {
            return Color.primary // Color for dates after today
        }
    }
    
    private func formattedDate(_ date: Date?, _ type: Int?) -> String {
        guard let date = date else {
            return ""
        }
        
        if type == 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            print(dateFormatter.string(from: date))
            return dateFormatter.string(from: date)

        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)

        }
        
    }




}
