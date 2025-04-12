# Stories sample app
App showcases a list of users and their stories in the top horizontal list.

*I 've decided to go over a broad set of feature.*

- User can scroll through them with the pagination.
- User can view each user's story separately.
- In preview user can navigate between stories and other user's stories by tapping left or right part of the screen. 
- User can like each story and it is saved using Swift Data.
- When User open and scroll the story they marked as "viewed".

I prioritized "vertical slice" of features and put less attention to individual interactions and transitions. 

### Libraries
I did not use any external libraries but the first one I would use would be image caching solution like SDWebImage. 

### Code Concepts
#### Stories Data Source
Provides data picked up from a predefined JSON. The avatars are from the service used in the sample and the stories photos are from a [diffreent API](https://picsum.photos)

#### Models
The feed uses `UserStoryEntry` model to represent a set of `Stories` of a specific `User`.
`StoryState` is used to store app user's interaction with stories.

#### Views and ViewModels
Using MVVM architecture. Each View has its own model to handle interactions and provide data.
##### HomeFeed
The parent home view. Holds the 'StoriesFeedView' and a mock of 'PostsFeedView'
##### PostsFeedView
Mocked feed of several mocked posts.
##### StoriesFeedView
The main screen to hold the scrollable list of users stories. Represents the state of views and new stories.
##### StoriesPreviewView
Screen to view each story. HAs navigation mechanincs and like button with consistent state.
#### Storage
Using **SwiftData** to store interactions between sessions

