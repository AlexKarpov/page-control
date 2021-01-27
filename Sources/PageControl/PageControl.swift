import SwiftUI

public struct PageControl: View {
    @State var pages: Int = 8
    @Binding var currentPage: Int
    
    var spacing: CGFloat = 10
    
    var tintColor: Color = .blue
    var selectedColor: Color = .red
    
    var calculatedCurrentPage: Int {
        currentPage % pages
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: spacing) {
                ForEach(0..<pages) { page in
                    let isCurrentPage = page == calculatedCurrentPage
                    Circle()
                        .scaledToFill()
    //                    .scaleEffect(isCurrentPage ? 1 : 0.5)
                        .foregroundColor(isCurrentPage
                                                ? selectedColor
                                                : tintColor)
                        .animation(.easeIn)
                }
            }
        }
        
        
        .scaledToFit()
        .overlay(
            GeometryReader { proxy in
                Circle()
                    .fill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .position(
                        x: proxy.size.width * CGFloat(calculatedCurrentPage) / CGFloat(pages) + (proxy.size.height / 2) + spacing * CGFloat(calculatedCurrentPage) / CGFloat(pages),
                        y: proxy.size.height/2
                    )
                    .animation(.spring())


            }

        )
//        .scaledToFit()
    }
}

struct PageControl_Previews: PreviewProvider {
    
    static var previews: some View {
        PageControlExample()
    }
}

public struct PageControlExample: View {
    @State var page: Int = 0
    
    public var body: some View {
        VStack {
            PageControl(currentPage: $page)
                .previewLayout(.sizeThatFits)
            Button("Switch page") {
                page += 1
            }
        }
    }
}
