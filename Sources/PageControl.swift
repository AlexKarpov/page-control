import SwiftUI

public struct PageControl: View {
    @State var pages: Int = 8
    @Binding var currentPage: Int
    
    var spacing: CGFloat = 10
    var tintColor: Color = .gray
    var selectedColor: Color = .white
    
    private var calculatedCurrentPage: Int {
        currentPage % pages
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: spacing) {
                ForEach(0..<pages) { page in
                    let isCurrentPage = page == calculatedCurrentPage
                    Circle()
                        .fixedSize()
                        .scaledToFill()
                        .foregroundColor(isCurrentPage ?selectedColor : tintColor)
                        .onTapGesture {
                            currentPage = page
                        }
                }
            }
        }
        .scaledToFit()
        .overlay(
            GeometryReader { proxy in
                let offset = proxy.size.width * CGFloat(calculatedCurrentPage) / CGFloat(pages) + spacing * CGFloat(calculatedCurrentPage) / CGFloat(pages)
                let width = (proxy.size.width / CGFloat(pages) - spacing + 1)
                RoundedRectangle(cornerRadius: proxy.size.height/2)
                    .foregroundColor(selectedColor)
                    .frame(
                        width: width,
                        height: proxy.size.height
                    )
                    .offset(x: offset)
            }
        )
        .animation(.default)
        .padding()
        .background(
            Color.gray.opacity(0.5)
                .blur(radius: 3.0)
                .clipShape(Capsule(style: .continuous))
        )
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
            PageControl(currentPage: $page)
                .previewLayout(.sizeThatFits)
            Button("Switch page") {
                page += 1
            }
        }
    }
}
