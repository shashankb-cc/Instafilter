//
//  ShareContent.swift
//  Instafilter
//
//  Created by Shashank B on 28/02/25.
//
//SwiftUI's ShareLink view lets users export content from our app to share elsewhere, such as saving a picture to their photo library, sending a link to a friend using Messages, and more.



import SwiftUI

struct ShareContent: View {
    var body: some View {
        VStack {
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check out the 100 Days of SwiftUI!"))
            //Second, you can customize the button itself by providing whatever label you want:
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }
            let example = Image(.room)

            ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
                Label("Click to share", systemImage: "airplane")
            }

        }

    }
}

#Preview {
    ShareContent()
}
