import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedPlatform = "YouTube"
    @State private var searchResults: [MediaItem] = []
    @State private var isSearching = false
    
    let platforms = ["YouTube", "Instagram", "TikTok", "X", "Threads"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 검색창
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("검색어 입력 (예: 투어스)", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                
                // 플랫폼 선택
                Picker("플랫폼", selection: $selectedPlatform) {
                    ForEach(platforms, id: \.self) { platform in
                        Text(platform).tag(platform)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // 검색 버튼
                Button(action: performSearch) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("검색")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                .disabled(searchText.isEmpty || isSearching)
                
                // 검색 결과
                if isSearching {
                    VStack {
                        ProgressView()
                        Text("검색 중...")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if searchResults.isEmpty && !searchText.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("검색 결과가 없습니다")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !searchResults.isEmpty {
                    List(searchResults) { item in
                        NavigationLink(destination: MediaDetailView(item: item)) {
                            MediaCell(item: item)
                        }
                    }
                } else {
                    VStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("\(selectedPlatform)에서\n검색을 시작하세요")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer()
            }
            .navigationTitle("10duck 검색")
        }
    }
    
    private func performSearch() {
        isSearching = true
        
        // 1.5초 후 샘플 데이터 표시
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            searchResults = generateSampleResults()
            isSearching = false
        }
    }
    
    private func generateSampleResults() -> [MediaItem] {
        return [
            MediaItem(
                id: "1",
                title: "투어스 \(searchText) - 최근 영상",
                platform: selectedPlatform,
                thumbnail: "photo",
                date: Date(),
                url: "https://example.com/1"
            ),
            MediaItem(
                id: "2",
                title: "투어스 \(searchText) - 인기 콘텐츠",
                platform: selectedPlatform,
                thumbnail: "photo",
                date: Date().addingTimeInterval(-86400),
                url: "https://example.com/2"
            ),
            MediaItem(
                id: "3",
                title: "투어스 \(searchText) - 추천 영상",
                platform: selectedPlatform,
                thumbnail: "photo",
                date: Date().addingTimeInterval(-172800),
                url: "https://example.com/3"
            )
        ]
    }
}

struct MediaCell: View {
    let item: MediaItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: item.thumbnail)
                .font(.system(size: 40))
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Text(item.title)
                .font(.headline)
                .lineLimit(2)
            
            HStack(spacing: 12) {
                Label(item.platform, systemImage: "globe")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(formatDate(item.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

#Preview {
    SearchView()
}
