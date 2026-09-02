import SwiftUI

struct InfoSearchView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "포카"
    @State private var searchResults: [InfoItem] = []
    
    let categories = ["포카", "착장", "기타"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("예: 투어스 포카", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                Picker("카테고리", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Button(action: searchInfo) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("정보 검색")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                
                if searchResults.isEmpty {
                    VStack {
                        import SwiftUI
                        
                        struct InfoSearchView: View {
                            @State private var searchText = ""
                            @State private var selectedCategory = "포카"
                            @State private var searchResults: [InfoItem] = []
                            
                            let categories = ["포카", "착장", "기타"]
                            
                            var body: some View {
                                NavigationStack {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(.gray)
                                            
                                            TextField("예: 투어스 포카", text: $searchText)
                                                .textFieldStyle(.roundedBorder)
                                        }
                                        .padding()
                                        
                                        Picker("카테고리", selection: $selectedCategory) {
                                            ForEach(categories, id: \.self) { category in
                                                Text(category).tag(category)
                                            }
                                        }
                                        .pickerStyle(.segmented)
                                        .padding()
                                        
                                        Button(action: searchInfo) {
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                Text("정보 검색")
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                        }
                                        .padding()
                                        
                                        if searchResults.isEmpty {
                                            VStack {
                                                Image(systemName: "info.circle")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.gray)
                                                Text("\(selectedCategory) 정보를\n검색하세요")
                                                    .foregroundColor(.gray)
                                                    .multilineTextAlignment(.center)
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        } else {
                                            List(searchResults) { item in
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text(item.title)
                                                        .font(.headline)
                                                    Text(item.description)
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                    
                                                    if let contentLink = item.contentLink {
                                                        Link("콘텐츠 보기 →", destination: contentLink)
                                                            .font(.caption)
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                                .padding(.vertical, 8)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .navigationTitle("정보 검색")
                                }
                            }
                            
                            private func searchInfo() {
                                searchResults = [
                                    InfoItem(
                                        id: "i1",
                                        title: "\(searchText) \(selectedCategory) 정보",
                                        description: "해당 정보를 찾았습니다",
                                        category: selectedCategory,
                                        contentLink: URL(string: "https://example.com")
                                    ),
                                    InfoItem(
                                        id: "i2",
                                        title: "\(searchText) 관련 \(selectedCategory)",
                                        description: "추가 정보입니다",
                                        category: selectedCategory,
                                        contentLink: URL(string: "https://example.com")
                                    )
                                ]
                            }
                        }

                        struct InfoItem: Identifiable {
                            let id: String
                            let title: String
                            let description: String
                            let category: String
                            let contentLink: URL?
                        }

                        #Preview {
                            InfoSearchView()
                        }
