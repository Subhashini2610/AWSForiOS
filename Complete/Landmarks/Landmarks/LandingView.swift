//
//  LandingView.swift
//  Landmarks
//
//  Created by Narayanaswamy, Subhashini (623) on 07/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    @ObservedObject public var user: UserData
    
    var body: some View {
        return VStack {
            if (!$user.isSignedIn.wrappedValue) {
               CustomLoginView()
            } else {
                LandmarkList().environmentObject(user)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        let app = UIApplication.shared.delegate as! AppDelegate
        return LandingView(user: app.userData)
    }
}
