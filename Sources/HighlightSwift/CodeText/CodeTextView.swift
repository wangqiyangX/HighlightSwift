import SwiftUI

@available(iOS 16.1, tvOS 16.1, *)
extension CodeText: View {
    public var body: some View {
        VStack(alignment: .leading) {
            if let fileName {
                Text(fileName)
                    .font(headerStyle.font)
                    .foregroundStyle(headerStyle.foregroundStyle)
                    .padding([.leading, .top], 8)
                Divider()
            }
            ScrollView(.horizontal) {
                Text(attributedText)
            }
            .scrollIndicators(.hidden)
            .padding(.vertical, style.verticalPadding)
            .padding(.horizontal, style.horizontalPadding)
        }
        .fontDesign(.monospaced)
        .textSelection(.enabled)
        .background {
            if let cardStyle = style as? CardCodeTextStyle {
                CodeTextCardView(
                    style: cardStyle,
                    color: highlightResult?.backgroundColor
                )
            }
        }
        .onAppear {
            guard highlightResult == nil else {
                return
            }
            highlightTask = Task {
                await highlightText()
            }
        }
        .onDisappear {
            highlightTask?.cancel()
        }
        .onChange(of: mode) { oldMode, newMode in
            highlightTask?.cancel()
            highlightTask = Task {
                await highlightText(mode: newMode)
            }
        }
        .onChange(of: colors) { oldColors, newColors in
            highlightTask?.cancel()
            highlightTask = Task {
                await highlightText(colors: newColors)
            }
        }
        .onChange(of: colorScheme) { oldColorScheme, newColorScheme in
            highlightTask?.cancel()
            highlightTask = Task {
                await highlightText(colorScheme: newColorScheme)
            }
        }
        .onChange(of: text) { oldText, newText in
            highlightTask?.cancel()
            highlightTask = Task {
                await highlightText()
            }
        }
    }
}

//  MARK: - Preview

@available(iOS 16.1, tvOS 16.1, *)
private struct PreviewCodeText: View {
    @State var language: HighlightLanguage = .swift
    @State var theme: HighlightTheme = .rosePine

    @State var currentValue: Double = 2.0

    var body: some View {
        List {
            CodeText(
                """
                import SwiftUI

                struct SwiftUIView: View {
                    var body: some View {
                        Text("Hello World!")
                            .font(.system(size: \(currentValue)))
                    }
                }
                """,
                fileName: "demo.swift"
            )
            .codeTextStyle(.card)
            .codeTextColors(.theme(theme))
            .highlightLanguage(language)
            .listRowInsets(EdgeInsets())

            Section("Control") {
                Picker("Language", selection: $language) {
                    ForEach(HighlightLanguage.allCases, id: \.self) { lang in
                        Text(lang.alias)
                            .tag(lang.alias)
                    }
                }
                Picker("Theme", selection: $theme) {
                    ForEach(HighlightTheme.allCases, id: \.self) { theme in
                        Text(theme.rawValue)
                            .tag(theme)
                    }
                }
                Slider(value: $currentValue, in: 0...10, step: 1) {
                    Text("Curret Value")
                }
            }
        }
    }
}

@available(iOS 16.1, tvOS 16.1, *)
#Preview {
    PreviewCodeText()
}
