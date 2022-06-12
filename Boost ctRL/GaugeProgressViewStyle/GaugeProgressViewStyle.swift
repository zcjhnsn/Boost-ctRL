import SwiftUI
import Combine

/// A progress view that visually indicates its progress using a gauge.
public struct GaugeProgressViewStyle<S: ShapeStyle & View, LowerLabel: View, UpperLabel: View>: ProgressViewStyle {
    private var shape: S
    private var thickness: CGFloat = 12
    private var indicatorColor: Color = .clear
    private var indicatorStrokeColor: Color = .black
    private var lowerLabel: () -> LowerLabel?
    private var upperLabel: () -> UpperLabel?
    
    /// Creates a view representing the body of a progress view.
    /// - Parameter configuration: The properties of the progress view being created.
    /// - Returns: A view representing the body of a progress view.
    public func makeBody(configuration: Configuration) -> some View {
        Gauge(
            shape: shape,
            thickness: thickness,
            value: configuration.fractionCompleted ?? 0,
            indicatorColor: indicatorColor,
            indicatorStrokeColor: indicatorStrokeColor
        ) {
            configuration.label
        } lowerLabel: {
            lowerLabel()
        } upperLabel: {
            upperLabel()
        }
    }
    
    init(
        shape: S,
        thickness: CGFloat = 12,
        indicatorColor: Color = .clear,
        indicatorStrokeColor: Color = .black,
        @ViewBuilder lowerLabel: @escaping () -> LowerLabel,
        @ViewBuilder upperLabel: @escaping () -> UpperLabel
    ) {
        self.shape = shape
        self.thickness = thickness
        self.indicatorColor = indicatorColor
        self.indicatorStrokeColor = indicatorStrokeColor
        self.lowerLabel = lowerLabel
        self.upperLabel = upperLabel
    }
}

// swiftlint:disable type_name
@available(iOS 15, tvOS 14, *)
struct GaugeProgressViewStyle_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressView(value: 0)
                .progressViewStyle(.gauge())
            
            ProgressView(value: 0.5) {
                Text("Gauge")
            }
            .progressViewStyle(.gauge())
            
            ProgressView(value: 0.5) {
                Text("Gauge")
            }
            .progressViewStyle(.gauge())
            
            ProgressView(value: 0.5) {
                Text("Gauge")
            }
            .progressViewStyle(
                .gauge {
                    Text("12")
                } upperLabel: {
                    Text("24")
                }
            )
            
            ProgressView(value: 0.5) {
                Text("Gauge")
            }
            .progressViewStyle(
                .gauge {
                    Image(systemName: "sun.max.fill")
                } upperLabel: {
                    Image(systemName: "cloud.rain.fill")
                }
            )
        }
        .padding()
        .previewLayout(.fixed(width: 250, height: 200))
    }
}
// swiftlint:enable type_name
