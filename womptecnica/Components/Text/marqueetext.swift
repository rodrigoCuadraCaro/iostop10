//MarqueeText.swift

import SwiftUI

struct MarqueeText : View {
    private let text: String
    
    private let font: UIFont
    
    private let separation: String
    
    private let scrollDurationFactor: CGFloat
    
    @State private var animate = false
    
    @State private var size = CGSize.zero
    
    private var scrollDuration: CGFloat {
        stringWidth * scrollDurationFactor
    }
    
    private var stringWidth: CGFloat {
        (text + separation).widthOfString(usingFont: font)
    }
    
    private func shouldAnimated(_ width: CGFloat) -> Bool {
        width < stringWidth
    }
    
    static private let defaultSeparation = " ++++ "
    
    static private let defaultScrollDurationFactor: CGFloat = 0.02
    
    init(_ text: String,
         font: UIFont = UIFont.preferredFont(forTextStyle: .body, compatibleWith: .current),
         separation: String = defaultSeparation,
         scrollDurationFactor: CGFloat = defaultScrollDurationFactor)         {
        self.text = text
        self.font = font
        self.separation = separation
        self.scrollDurationFactor = scrollDurationFactor
        self.animate = animate
    }
    
    init(_ text: String,
         textStyle: UIFont.TextStyle,
         separation: String = defaultSeparation,
         scrollDurationFactor: CGFloat = defaultScrollDurationFactor)
    {
        self.init(text, font: UIFont.preferredFont(forTextStyle: textStyle, compatibleWith: .current), separation: separation, scrollDurationFactor: scrollDurationFactor)
    }
    
    var body : some View {
        GeometryReader { geometry in
            let shouldAnimate = shouldAnimated(geometry.size.width)

            Text(shouldAnimate ? text + separation + text + separation : text + separation)
                .lineLimit(1)
                .font(Font(uiFont: font))
                .offset(x: animate ? -stringWidth : 0)
                .animation(Animation.linear(duration: scrollDuration).repeatForever(autoreverses: false), value: animate)
                .fixedSize(horizontal: true, vertical: false)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .onAppear() {
                    size = geometry.size
                    if shouldAnimate {
                        self.animate = true
                    }
                }
        }
    }
    
    private func scrollItem(offset: CGFloat) -> some View {
        Text(text + separation)
            .lineLimit(1)
            .font(Font(uiFont: font))
            .offset(x: offset)
            .animation(Animation.linear(duration: scrollDuration).repeatForever(autoreverses: false), value: animate)
            .fixedSize(horizontal: true, vertical: false)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }

}

private extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

private extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
