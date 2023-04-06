//
//  AppTabBarContainerView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/31/23.
//

import SwiftUI

struct AppTabBarContainerView<Content : View> : View {
    
    @Binding var selection : TabBarItem
    let content : Content
    @State private var tabs : [TabBarItem] = []
    @Binding private var hideTabBar : Bool
    
    public init(selection: Binding<TabBarItem>, hideTabBar : Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self._hideTabBar = hideTabBar
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea(edges : .bottom)
            AppTabBarView(tabs: tabs, selection: $selection, localSelection: selection,isHidden: $hideTabBar, localHide: hideTabBar)
                
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct AppTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs : [TabBarItem] = [.home,.favourite,.profile]
        AppTabBarContainerView(selection: .constant(tabs.first!), hideTabBar: .constant(false)) {
            Color.red
        }
    }
}
