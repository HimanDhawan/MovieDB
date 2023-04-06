//
//  AppTabBarView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/31/23.
//

import SwiftUI

struct AppTabBarView: View {
    
    let tabs : [TabBarItem]
    @Binding var selection : TabBarItem
    @Namespace private var nameSpace
    @State var localSelection : TabBarItem
    
    @Binding var isHidden : Bool
    @State var localHide : Bool
    
    var body: some View {
        tabBar
            .opacity(localHide ? 0.0 : 1.0)
            .onChange(of: isHidden, perform: { newValue in
                withAnimation(.linear) {
                    print("Local hide = \(newValue)")
                    localHide = newValue
                }
            })
            .onChange(of: selection) { newValue in
                withAnimation(.easeOut) {
                    localSelection  = selection
                }
            }
    }
}

extension AppTabBarView {
    private func tabView(tabBarItem : TabBarItem) -> some View {
        VStack {
            Image(systemName: tabBarItem.iconName)
                .font(.subheadline)
            Text(tabBarItem.name)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
        }
        .foregroundColor(localSelection == tabBarItem ? tabBarItem.color : Color.gray)
        .padding(.vertical,8)
        .frame(maxWidth: .infinity)
        .background (
            ZStack {
                if localSelection == tabBarItem {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tabBarItem.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectange", in: nameSpace)
                }
            }
        )
    }
    private var tabBar : some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tabBarItem: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.white.ignoresSafeArea(edges : .bottom)
        )
        .cornerRadius(10)
        .shadow(color: .black, radius: 10, y : 5)
        .padding(.horizontal)
        .opacity(isHidden ? 0.0 : 1.0)
    }
    
    private func switchToTab(tab : TabBarItem) {
        selection = tab
    }
    
}

struct AppTabBarView_Previews: PreviewProvider {
    
    static let tabs : [TabBarItem] = [.home,.favourite,.profile]
    
    static var previews: some View {
        VStack {
            Spacer()
            AppTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!, isHidden: .constant(false),localHide: false)
        }
    }
}

