//
//  ContentView.swift
//  PickerDemo
//
//  Created by David M Reed on 2/4/21.
//

import SwiftUI

struct BasicPicker: View {

    private var options = ["Left", "Center", "Right"]
    private var imageNames: [String]
    @State private var selection: Int = 0

    init() {
        imageNames = options.map { "text.align\($0.lowercased())" }
    }

    var body: some View {
        Picker("", selection: $selection) {
            ForEach(options.indices, id: \.self) { idx in
                HStack {
                    Text(options[idx])
                        .frame(width: 100, alignment: .leading)
                    Image(systemName: imageNames[idx])
                }
                .tag(idx)
            }
        }
        .onChange(of: selection, perform: { value in
            print("selected", options[value])
        })
        .onDisappear() {
            print("on dismiss: selected", options[selection])
        }
    }
}


struct ContentView: View {
    @State private var showBasicPicker = false
    @State private var showColorPicker = false
    @State private var showDatePicker = false
    @State private var selectedColor = Color.red
    @State private var selectedDate = Date()


    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 24) {
                    Button("Basic"){
                        showBasicPicker = true
                    }
                    .sheet(isPresented: $showBasicPicker) {
                        BasicPicker()
                    }

                    Button("Color") {
                        showColorPicker = true
                    }
                    .sheet(isPresented: $showColorPicker) {
                        ColorPicker("color", selection: $selectedColor)
                            .labelsHidden()
                    }

                    Button("Date") {
                        showDatePicker = true
                    }
                    .sheet(isPresented: $showDatePicker) {
                        DatePicker("Selected date", selection: $selectedDate)
                            .labelsHidden()
                    }
                }
                .padding(.top, 16)

                // if put picker in a Form and the Form is inside a NavigationView
                // it will navigate to a list for you to pick
                // otherwise on iOS get a WheelPickerStyle() for the basic Picker
                Form {
                    BasicPicker()
                        // even if in a Form can force WheelPickerStyle if you want
                        .pickerStyle(WheelPickerStyle())
                    ColorPicker("Selected Color", selection: $selectedColor)
                        .labelsHidden()
                    DatePicker("Selected date", selection: $selectedDate)
                }

            }.navigationBarTitle("Pickers", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
