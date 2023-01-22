# Tweetarium
- Tweetarium is a third-party client using Twitter API v1.1.

## Technologies Used
- The app was written in **Swift 5.6**
- User interface is built using **UIKit** (nib files, no storyboards)
- Preferences page was built using **SwiftUI** forms and integrated into the app using **UIHostingController**.
- User authentication and request authorization layer is built for **OAuth1.0**
- Networking layer written for **URLSession** using protocols, generics and enums.
- The app was built using the **MVVM** architecture.
- Navigation is done programmatically using the **coordinator** Pattern.
- View Controllers, Tab Bar and alerts are created using the **factory** pattern.
- Binding between view models and view controllers is done using the **bindings pattern** (Home-made reactive programming)

## Screenshots
<img src="https://i.imgur.com/kbFJbzX.png" alt="Tweetarium" style="width:300px"/>
<img src="https://i.imgur.com/qdb6gjO.png" alt="Tweetarium" style="width:300px"/>
<img src="https://i.imgur.com/mjThvSd.png" alt="Tweetarium" style="width:300px"/>
<img src="https://i.imgur.com/wYTNl9Z.png" alt="Tweetarium" style="width:300px"/>
<img src="https://i.imgur.com/boT96w0.png" alt="Tweetarium" style="width:300px"/>
<img src="https://i.imgur.com/zwewIF1.png" alt="Tweetarium" style="width:300px"/>


## Features
- View tweets from the home timeline.
- View user mentions.
- View user personal tweets.
- Interaction with tweets (Likes, Retweets, Quotes, Replies)
- Writing Your own tweets (only pure-text tweets are supported at the moment)
- Infinite scrolling using pagination
- Dark Mode Control
- Localization (English and Arabic are supported)

## Installation
- Login to the Twitter Developer Portal and create a new OAuth1.0 app.
- Clone the repo to your local device
- Replace the keys in the repository with your own keys
```
struct APIKeys {
    static let key = "ENTER_YOUR_CLIENT_KEY"
    static let secret = "ENTER_YOUR_CLIENT_SECRET"
    static let callback = "ENTER_YOUR_CALLBACK_SCHEME"
}
```

## Todo List
- View user details and metrics.
- View advanced tweet metrics.
- Post image tweets.
- Add tweet search.
- Add offline tweet bookmarking using CoreData.
