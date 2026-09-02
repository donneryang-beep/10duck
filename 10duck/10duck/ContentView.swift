import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 탭 1: 검색
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .tag(0)
            
            // 탭 2: 소장
            CollectionView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("소장")
                }
                .tag(1)
            
            // 탭 3: 정보 검색
            InfoSearchView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("정보")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
