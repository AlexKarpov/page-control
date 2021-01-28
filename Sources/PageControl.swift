import SwiftUI

public struct PageControl: View {
    @State var pages: Int = 3
    @Binding var currentPage: Int
    @State var spacing: CGFloat = 10
    
    var tintColor: Color = .gray
    var selectedColor: Color = .white
    
    private var calculatedCurrentPage: Int {
        currentPage % pages
    }
    
    private var pageControl: some View {
        HStack(spacing: spacing) {
            ForEach(0..<pages) { page in
                let isCurrentPage = page == calculatedCurrentPage
                Circle()
                    .fixedSize()
                    .scaledToFill()
                    .foregroundColor(isCurrentPage ? selectedColor : tintColor)
                    .onTapGesture {
                        currentPage = page
                    }
            }
        }
        .overlay(
            GeometryReader { proxy in
                let offset = proxy.size.width * CGFloat(calculatedCurrentPage) / CGFloat(pages) + (proxy.size.height / 2) + spacing * CGFloat(calculatedCurrentPage) / CGFloat(pages) - proxy.size.width / 2
                Circle()
                    .foregroundColor(selectedColor)
                    .offset(x: offset)
            }
        )
        
        .padding()
        .background(
            Color.gray.brightness(0.20).opacity(1)
                .clipShape(Capsule(style: .continuous))
        )
        .animation(.default)
    }
    
    @ViewBuilder
    public var body: some View {
        if spacing > 0 {
            pageControl
        } else {
            EmptyView()
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    
    static var previews: some View {
        PageControlExample()
            .previewLayout(.sizeThatFits)
            
    }
}

public struct PageControlExample: View {
    @State var page: Int = 0
    
    public var body: some View {
        VStack {
            PageControl(pages: 8, currentPage: $page)
            Button("Switch page") {
                page += 1
            }
        }
    }
}
