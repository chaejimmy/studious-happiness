////
//  AnimatedGrid.swift
//  bug-free-goggles
//
//  Created by Mac on 9/8/23.
//

import SwiftUI

struct AnimatedGrid: View {
    @Binding var selectedTime: Date?
    var duration: Int
    
    let columns = 2 // Number of columns in the grid
    let spacing: CGFloat = 16 // Spacing between views
    
    @State private var isVisible = Array(repeating: false, count: 40)
    
    let bookedTimes = (0..<40).map { _ in Int.random(in: 1...3) == 2 }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns), spacing: spacing) {
                ForEach(Array(dateList.enumerated()), id: \.element) { index, date in
                    GridItemView(label: fomrattedDate(date)
                                 ,
                                 isSelected: selectedTime == date, isBooked: bookedTimes[index])
                    .opacity(isVisible[index] ? 1 : 0)
                    .onAppear {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isVisible[index] = true
                            }
                        }
                    }
                    .onTapGesture {
                        if bookedTimes[index] {return}
                        selectedTime = date
                    }
                }
            }
            .padding()
        }
    }
    
    func fomrattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    
    let dateString = "2023-11-25T08:00:08.062Z"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter
    }()
    
    var endDate: Date {
        if let date = dateFormatter.date(from: dateString) {
            return Calendar.current.date(byAdding: .hour, value: 24, to: date)!
        }
        return Date()
    }
    
    var dateList: [Date] {
        var dates: [Date] = []
        var currentDate = dateFormatter.date(from: dateString) ?? Date()
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        }
        
        return dates
    }
   
}

struct AnimatedGrid_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGrid(selectedTime: Binding.constant(nil), duration: 1)
    }
}


struct GridItemView: View {
    var label: String
    var isSelected: Bool
    var isBooked: Bool
    var body: some View {
  
        ZStack{
            RoundedRectangle(cornerRadius: 100)
                .fill(isSelected ? Color.darkIndigo : Color.midGray)
                .frame(width: 151, height: 45)
            
            Text(label)
                .foregroundColor(isSelected ? Color.white: Color.black)
        } .opacity(isBooked ? 0.3 : 1)
        
    }
    
    
}

