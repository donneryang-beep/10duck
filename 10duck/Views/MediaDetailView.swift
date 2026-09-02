import SwiftUI

struct MediaDetailView: View {
    let item: MediaItem
    @State private var isSaved = false
    @State private var isDownloading = false
    @State private var downloadProgress: Double = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // 썸네일
                Image(systemName: item.thumbnail)
                    .font(.system(size: 80))
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                
                // 정보
                VStack(alignment: .leading, spacing: 12) {
                    Text(item.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Label(item.platform, systemImage: "globe")
                        Spacer()
                        Text(formatDate(item.date))
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
                
                // 원본 링크
                Link(destination: URL(string: item.url) ?? URL(fileURLWithPath: "")) {
                    HStack {
                        Image(systemName: "link")
                        Text("원본 보기")
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                }
                
                // 액션 버튼
                VStack(spacing: 12) {
                    if isDownloading {
                        VStack(spacing: 8) {
                            ProgressView(value: downloadProgress)
                            Text("\(Int(downloadProgress * 100))% 다운로드 중...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Button(action: downloadMedia) {
                            HStack {
                                Image(systemName: "arrow.down.circle")
                                Text("다운로드")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    
                    Button(action: toggleSave) {
                        HStack {
                            Image(systemName: isSaved ? "heart.fill" : "heart")
                            Text(isSaved ? "저장됨" : "저장하기")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSaved ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
                        .foregroundColor(isSaved ? .red : .gray)
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("상세 정보")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func downloadMedia() {
        isDownloading = true
        downloadProgress = 0
        
        // 다운로드 시뮬레이션
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            downloadProgress += 0.05
            
            if downloadProgress >= 1.0 {
                timer.invalidate()
                isDownloading = false
                isSaved = true
            }
        }
    }
    
    private func toggleSave() {
        isSaved.toggle()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

#Preview {
    MediaDetailView(item: MediaItem(
        id: "1",
        title: "테스트 영상",
        platform: "YouTube",
        thumbnail: "photo",
        date: Date(),
        url: "https://example.com"
    ))
}
