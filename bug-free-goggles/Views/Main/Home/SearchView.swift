////
//  SearchView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/3/23.
//

import SwiftUI
import HorizonCalendar

struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel.shared
    @StateObject private var calendarManager = CalendarManager.shared
    @State var searchType: SearchType = .stay
    let dismiss: () -> Void
    
    let categoriesIcon = ["Australia", "Canada", "Germany", "United Kingdom", "United Arab Emirates"]
    
    var body: some View {
        
        VStack(spacing: 16) {
            VStack{
                HStack {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .padding(10)
                            .foregroundColor(.darkGray)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                ScrollView(.horizontal, showsIndicators: false) {
                    SearchTypeSelectionView(selectedType: searchType) { searchType in
                        withAnimation {
                            self.searchType = searchType
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            ScrollView {
                whereCollapsable
                whenCollapsable
                whoCollapsable
            }
            
            ZStack(alignment: .top) {
                Color.white
                HStack{
                    Button(action: {
                        // Button action
                    }) {
                        Text("Clear all")
                            .foregroundColor(.black)
                            .fontWeight(.bold).padding(.trailing, 20)
                            .underline()
                    }
                    .padding(.vertical)
                    .padding(.leading, 30)
                    Spacer()
                    Button(action: {
                        // Button action
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            Text("Search")
                                .foregroundColor(.white)
                                .fontWeight(.bold).padding(.trailing, 20)
                        }
                        .frame( height: 50)
                        .background(Color.lightIndigo)
                        .cornerRadius(14)
                    }
                    .padding(.vertical)
                    .padding(.trailing, 30)
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.midGray)
            }
            .frame(height: 30)
            
        }
        .background(Color.grayBackground)
        
    }
    
    
    var whereCollapsable: some View {
        Collapsible(
            collapsed: $searchVM.isWhereCollapsed,
            collapsedHeader:{
                AnyView( HStack{
                    Text("Where")
                        .fontWeight(.bold)
                        .font(Font.system(size: 19))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Australia")
                        .fontWeight(.bold)
                        .font(Font.system(size: 15))
                }.padding())
            },
            label: { Text("Where to?")
                    .fontWeight(.bold)
                .font(Font.system(size: 19)) },
            content: {
                VStack{
                    HStack{
                        HStack {
                            TextField("Search destinations", text: $searchVM.searchText)
                                .font(.system(size: 17, weight: .regular))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image("searchIcon")
                                .resizable()
                                .frame(width: 20, height: 20).padding(.leading, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth:1)
                        }
                        
                    }
                    
                    HStack{
                        Text("Popular destinations")
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding(.top, 10)
                    
                    ForEach(categoriesIcon, id: \.self) { country in
                        HStack {
                            Image("location")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                            Text(country)
                                .fontWeight(.light)
                                .font(Font.system(size: 16))
                            Spacer()
                        }
                    }
                }.padding()
                
                
            }
        ){
            searchVM.isWheneCollapsed = true
            searchVM.isWhoCollapsed = true
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,7)
        .padding(.bottom)
    }
    
    
    var whenCollapsable: some View {
        Collapsible(
            collapsed: $searchVM.isWheneCollapsed,
            collapsedHeader:{
                AnyView( HStack{
                    Text("When")
                        .fontWeight(.bold)
                        .font(Font.system(size: 19))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Select Date")
                        .fontWeight(.bold)
                        .font(Font.system(size: 15))
                }.padding())
            },
            label: { Text("When's your trip?")
                    .fontWeight(.bold)
                .font(Font.system(size: 19)) },
            content: {
                VStack{
                    RangeDatePicker()
                }
            }
        ){
            searchVM.isWhereCollapsed = true
            searchVM.isWhoCollapsed = true
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,7)
        .padding(.bottom)
    }
    
    
    var whoCollapsable: some View {
        Collapsible(
            collapsed: $searchVM.isWhoCollapsed,
            collapsedHeader:{
                AnyView( HStack{
                    Text("Who")
                        .fontWeight(.bold)
                        .font(Font.system(size: 19))
                        .foregroundColor(.gray)
                    Spacer()
                    Text(searchVM.guests > 0 ? "\(searchVM.guests) guests" : "Add guests")
                        .fontWeight(.bold)
                        .font(Font.system(size: 15))
                }.padding())
            },
            label: { Text("Who's coming?")
                    .fontWeight(.bold)
                .font(Font.system(size: 19)) },
            content: {
                VStack{
                    
                    CounterView(lable: "Adult", subLable: "Ages 13 or above"){count in
                        
                    }
                    CounterView(lable: "Children", subLable: "Ages 2-12"){count in
                        
                    }
                    CounterView(lable: "Infants", subLable: "Ages 0-2"){count in
                        
                    }
                }.padding()
                
                
            }
        ){
            searchVM.isWhereCollapsed = true
            searchVM.isWheneCollapsed = true
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,7)
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() {}
    }
}


