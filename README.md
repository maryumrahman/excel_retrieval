# excel_retrieval

Project to facilitate my personal endeavors and passion work. 
1. Recipe management:
   a. take a screenshot, send it to app with image picker.
   b. process picture and extract all the text. textService.
   c. clean the text, remove excess text with openAI's apiService.
   d. recognize key words with openAI's apiService.
   e. place those sentences in their respective headings.
   f. show a standard format of 4 types of cards, ui colors, instructions sequence.
   g. also extract pictures and show them in their own card format.
   h. give options to save the recipe in the diary, send to database with api call to mongo db. 
   i. give option to clear the diary or individual recipe (unfavorite). 
   j. give option to make recipe available in pro accounts public forum with your name and credit points. enough credit points a month unlocks pro feature for a month.
   k. give options to remove your recipe from the database (soft delete).
   l. give option to not turn screen off. give option to display cards a certain color. give options to display pictures first or last. give options to send review to developer. (to choose which icons in place of words.)
   m. give option to favorite the recipe.
   n. give option to send rating (thunbs up or down).
   o. cards have: picture, name, pressing icon.
   p. long press card to show number of steps, number of ingredients, rating box. 
   q. app has help overlay: give instructions to long press, add to pro, get pro for a month, change look with settings.
   r. press picture card, go on to recipe page: shows cards. has heading and icons (Mix. banana icon, cream icon) . press card to make it expand. progress the recipe showing cards as they are required in the sequence of steps.  last is tips card.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
