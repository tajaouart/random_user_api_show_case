# random_user_api


###  Important 

The project uses some code-generation libraries so ensure to run the following command:

```sh
 flutter pub run build_runner build --delete-conflicting-outputs
```


### Technical Choices

- For the API client, I used the `dio` package to make the HTTP requests.
- For the local storage, I used the `sqflite` package to interact with the SQLite database.
- I used the `freezed_annotation` package to generate immutable data classes for the `User` model.
- I used the `either_dart` package to handle the error cases when fetching the users from the API.
- I used the `injectable` package to provide dependency injection for the various services in the app.
- I used the `provider` package to manage the state of the app.

### Architectural Decisions

- I decided to use the repository pattern to separate the logic for fetching the users from the API and the local storage.
- I used the ViewModel pattern to separate the business logic from the UI.
- I created a `UserRepository` class that handles the logic for fetching the users from the API and the local storage.
- I created a `UserDao` class that handles the logic for interacting with the local SQLite database.
- I created a `UserViewModel` class that handles the logic for displaying the users in the UI and managing the state of the app.

### What I could have done with more time

- I could have added a progressBarIndicator while fetching new page of results.
- I could have made a better ui.
- I could have cached the images.
- I could have added tests.



### In a real-world environment

In a real-world environment, I would have split the work into smaller reviewable sub-tasks. For example:

- Creating the `User` model and the `UserRepository`.
- Creating the `UserViewModel` and the UI for displaying the list of users.
- Creating the details page for the users.
- Implementing the offline mode feature(`UserDao` classes...) by storing the users in the local SQLite database.
- Implementing the pagination feature.
