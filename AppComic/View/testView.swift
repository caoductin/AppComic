////
////  testView.swift
////  AppComic
////
////  Created by cao duc tin  on 30/9/24.
////
import SwiftUI
import SwiftData
struct HomeView: View {
    @State private var selectedTab: TabCategory = .law
    @State private var isTabFullScreenPresented: Bool = false
    @State private var selectedIndex: Int = 0 // Store the index of the selected tab

    let tabs: [TabCategory] = TabCategory.allCases // Use the enum's cases

    var body: some View {
        VStack {
            // Tab Bar trên đầu
            ScrollViewReader { scrollViewProxy in
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(tabs.indices, id: \.self) { index in
                                let tab = tabs[index]
                                
                                Button(action: {
                                    selectedTab = tab
                                    selectedIndex = index
                                    
                                    // Scroll to the selected tab and center it
                                    withAnimation {
                                        scrollViewProxy.scrollTo(index, anchor: .center)
                                    }
                                }) {
                                    Text(tab.rawValue)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(selectedTab == tab ? Color.blue : Color.clear)
                                        .foregroundColor(selectedTab == tab ? .white : .blue)
                                        .cornerRadius(10)
                                }
                                .id(index) // Assign ID for ScrollViewReader to recognize
                            }
                        }
                    }
                    // List Dash Icon to present the full tab list
                    Button(action: {
                        isTabFullScreenPresented = true // Show the sheet
                    }) {
                        Image(systemName: "list.dash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .fullScreenCover(isPresented: $isTabFullScreenPresented) {
                        TabSelectionFullScreenView(tabs: TabCategory.allCases, selectedTab: $selectedTab, selectedIndex: $selectedIndex)
                    }
                    .onChange(of: selectedIndex, { oldValue, newValue in
                        withAnimation {
                            scrollViewProxy.scrollTo(newValue, anchor: .center)
                        }
                    })
                }
                .padding()
                .background(Color.gray.opacity(0.2)) // Background cho TabBar
            }
            
            // Nội dung Tab thay đổi theo tab được chọn
            Spacer()
            switch selectedTab {
            case .newest:
                TabHomeView(selectedCategory: TabCategory.newest.rawValue)
            case .law:
                TabHomeView(selectedCategory: TabCategory.law.rawValue)
            case .education:
                TabHomeView(selectedCategory: TabCategory.education.rawValue)
            case .entertainment:
                TabHomeView(selectedCategory: TabCategory.entertainment.rawValue)
            case .travel:
                TabHomeView(selectedCategory: TabCategory.travel.rawValue)
            case .sports:
                TabHomeView(selectedCategory: TabCategory.sports.rawValue)
            case .science:
                TabHomeView(selectedCategory: TabCategory.science.rawValue)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//struct testView: View {
//    @State private var selectedTab: String = "Pháp luật"
//    @State private var isTabFullScreenPresented: Bool = false
//    @State private var selectedIndex: Int = 0 // Store the index of the selected tab
//
//    let tabs = ["Mới nhất","Pháp luật", "Giáo dục", "Giải trí", "Du lịch", "Thể thao","Khoa học"]
//    
//    var body: some View {
//        VStack {
//            // Tab Bar trên đầu
//            ScrollViewReader { scrollViewProxy in
//                HStack {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack {
//                            ForEach(tabs.indices, id: \.self) { index in
//                                let tab = tabs[index]
//                                
//                                Button(action: {
//                                    selectedTab = tab
//                                    selectedIndex = index
//                                    
//                                    // Scroll to the selected tab and center it
//                                    withAnimation {
//                                        scrollViewProxy.scrollTo(index, anchor: .center)
//                                    }
//                                }) {
//                                    Text(tab)
//                                        .padding(.vertical, 10)
//                                        .padding(.horizontal, 20)
//                                        .background(selectedTab == tab ? Color.blue : Color.clear)
//                                        .foregroundColor(selectedTab == tab ? .white : .blue)
//                                        .cornerRadius(10)
//                                }
//                                .id(index) // Assign ID for ScrollViewReader to recognize
//                            }
//                        }
//                    }
//                    // List Dash Icon to present the full tab list
//                    Button(action: {
//                        isTabFullScreenPresented = true // Show the sheet
//                    }) {
//                        Image(systemName: "list.dash")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20)
//                    }
//                    .fullScreenCover(isPresented: $isTabFullScreenPresented) {
//                        TabSelectionFullScreenView(tabs: tabs, selectedTab: $selectedTab, selectedIndex: $selectedIndex)
//                    }
//                    .onChange(of: selectedIndex, { oldValue, newValue in
//                        withAnimation {
//                            scrollViewProxy.scrollTo(newValue, anchor: .center)
//                        }
//                    })
//                
//
//                }
//                .padding()
//                .background(Color.gray.opacity(0.2)) // Background cho TabBar
//            }
//            
//            // Nội dung Tab thay đổi theo tab được chọn
//            Spacer()
//            if selectedTab == "Mới nhất"{
//                HomeView(selectedCategory:"Mới nhất")
//            }
//            else if selectedTab == "Pháp luật" {
//                HomeView( selectedCategory: "pháp luật")
//            } else if selectedTab == "Giáo dục" {
//                HomeView(selectedCategory:"Giáo dục")
//            } else if selectedTab == "Giải trí" {
//                HomeView( selectedCategory: "giải trí")
//            } else if selectedTab == "Du lịch" {
//                HomeView( selectedCategory: "Du lịch")
//            } else if selectedTab == "Thể thao" {
//                HomeView( selectedCategory: "thể thao")
//            }
//            else if selectedTab == "Khoa học"{
//                HomeView(selectedCategory:"Khoa học")
//
//            }
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//      
//               
//    }
//}

// Separate view for tab selection
struct TabSelectionFullScreenView: View {
    let tabs: [TabCategory] // Change to use the enum
    @Binding var selectedTab: TabCategory // Change to use the enum
    @Binding var selectedIndex: Int
    @Environment(\.dismiss) var dismiss // For closing the full-screen view
    
    var body: some View {
        NavigationView {
            VStack {
                List(tabs.indices, id: \.self) { index in
                    let tab = tabs[index]
                    
                    Button(action: {
                        selectedTab = tab // Set the selected tab using enum
                        selectedIndex = index
                        
                        dismiss() // Close the view after selecting a tab
                    }) {
                        Text(tab.rawValue) // Display the tab's raw value
                            .foregroundColor(selectedTab == tab ? .blue : .primary)
                    }
                }
                .listStyle(.plain) // Simplified list style
                
                Button(action: {
                    dismiss() // Close the full-screen view
                }) {
                    Text("Đóng")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar to make it full-screen
        }
    }
}

#Preview {
    HomeView()
}
