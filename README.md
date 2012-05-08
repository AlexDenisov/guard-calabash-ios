# Guard::Frank

Guard gem for [Frank-Cucumber](http://www.testingwithfrank.com/).    
Guard::Frank automatically run your frank-cucumber features for iOS.    

## Installation

    $ gem install guard-frank

## Usage

Add support of the frank-cucumber to your project as [described](http://www.testingwithfrank.com/installing.html).    
Then go to the Xcode settings and setup Derived Data as Relative.

![Xcode locations](https://github.com/AlexDenisov/guard-frank/blob/master/locations.png?raw=true).

When you're done, run following commands from project_path/Frank directory

    $ guard init frank
    $ guard

Note that Frank needs to know which target of project you want to test.     
So after initilizing frank you need modify Guardfile, if neccessary.     
By default Guard::Frank trying to test 'frankified' target.     

