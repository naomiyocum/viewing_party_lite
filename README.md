<h1 align="center"> Viewing Party 🎥  </h1>

![GitHub Contributors](https://img.shields.io/github/contributors/naomiyocum/viewing_party_lite)
![GitHub top language](https://img.shields.io/github/languages/top/naomiyocum/viewing_party_lite?color=yellow)

<figure>
<img src="https://user-images.githubusercontent.com/102825498/209204028-6b4fd8c7-0ddf-4c61-92e6-7aab85cb7125.png" alt="User Dashboard" style="width:100%">
<figcaption align="center"><b>Example view of a user's dashboard (http://localhost:3000/dashboard)</b></figcaption>
</figure><br><br>

## Table of Contents
* [General Info](#general-info)
* [Learning Goals](#learning-goals)
* [Technologies](#technologies)
* [Schema Design](#schema-design)
* [Usage](#usage)

## General Info
Viewing Party Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application. Features include browsing top rated movies, searching for movies by title, and viewing movie data such as vote average, cast, runtime, and reviews.

This is the base repo for the [Viewing Party Lite project](https://backend.turing.edu/module3/projects/viewing_party_lite) used for Turing's Backend Module 3. Example wireframes to follow are found [here](https://backend.turing.edu/module3/projects/viewing_party_lite/wireframes).

## Learning Goals
- Consume JSON APIs that require authentication 
- Test consumption of APIs (facades, services, poros)
- Organize and refactor code to be more maintainable
- Apply RuboCop’s style guide for code quality
- Authentication and authorization implementation

## Technologies

- Ruby 2.7.2
- Rails 5.2.6

## Schema Design
![Screen Shot 2022-12-22 at 11 26 27 AM](https://user-images.githubusercontent.com/102825498/209202319-17d0c8a3-b201-4173-a4c2-9e9f80a3586e.png)

## Usage

Clone the repo by running `git clone` with the copied URL onto your local machine

Then, run the following commands:
```
cd viewing_party_lite
bundle install
rails db:{drop,create,migrate,seed}
bundle exec figaro install
```

The Figaro installation will create a commented  `config/application.yml` file. This is where you want to add your [Movie DB](https://developer.themoviedb.org/docs) API key.

Then open up your server by running `rails s`. 

Lastly, head to your web browser and type `localhost:3000` and click enter.

Now you're on the main page! Go ahead and register as a new user and search for your favorite movie to create a viewing party!

To run tests - `bundle exec rspec`


