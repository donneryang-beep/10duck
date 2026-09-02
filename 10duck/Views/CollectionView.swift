import SwiftUI

struct CollectionView: View {
    @State private var savedItems: [MediaItem] = [
        MediaItem(
            id: "s1",
            title: "저장된 투어스 영상 1",
            platform: "YouTube",
            thumbnail: "heart.fill",
            date: Date().addingTimeInterval(-86400),
            url: "https://example.com/s1",
            isSaved: true
        )
    ]
    @State private var sortBy = "최신순"
    
    let sortOptions = ["최신순", "오래된순", "플랫폼별"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("정렬", selection: $sortBy) {
                    ForEach(sortOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if savedItems.isEmpty {
                    VStack {
                        Image(systemName: "heart")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("저장된 자료가 없습니다")
                            .foregroundColor(.gray)
                        Text("검색에서 다운로드하세요")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(sortedItems) { item in
                        NavigationLink(destination: MediaDetailView(item: item)) {
                            MediaCell(item: item)
                        }
                    }
                }
            }
            .navigationTitle("소장함")
        }
    }
    
    private var sortedItems: [MediaItem] {
        switch sortBy {
        case "최신순":
            return savedItems.sorted { $0.date > $1.date }
        case "오래된순":
            return savedItems.sorted { $0.date < $1.date }
        case "플랫폼별":
            return savedItems.sorted { $0.platform < $1.platform }
        default:
            return savedItems
        }
    }
}

#Preview {
    CollectionView()
}
