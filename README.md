# Preimier-league-X
Premieer League X Fetching and displaying premier league matches in descending date

## Architecture
Built With MVVM architecture as this project is scalable to far limits as well as MVVM simplifies testing.
We will explain most important folders:
- Services: this layer has application dependancies like network layer, core data layer(for future updates to store matches locally)
- Extensions: have Swift classes extension functions
- MVVM: has base application structures
   - Models: which has Codable models and API call classes
   - View: includes(storyboard, viewControllers and andy custom UI which used withen this module.
   - ViewModel: include business logic for matches with fetching, filtering and send actions to its view.

- I Built BaseViewController class which used as blueprint for common functionalities any UIViewController in the app.
- BaseViewController conferming to BaseDisplay protocol which have basic
- Also messages showed to user when error occured or any hint, has a class with abstraction layer for DI use.
## Local Dependancies
I made one main dependancy in this application which is ArrangeMatchManager class this class help ViewModel query match list according to our need like.
- Arrange match list to be Deascending from newer to the older match.
- Query arranget matched and remove any match which from begining of the season to current time.
- Help secion items to give our ViewModel last section and row place to set.
