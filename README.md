# Guard::CalabashiOS

Guard gem for [Calabash-ios](https://github.com/calabash/calabash-ios).    
Guard::CalabashiOS automatically run your cucumber features for iOS.    

## Installation

    $ gem install guard-calabash-ios

## Usage

Add support of the calabash to your project
as [described](https://github.com/calabash/calabash-ios/wiki/01-Getting-started-guide).    
Then go to the Xcode settings and setup Derived Data as Relative.

![Xcode locations](https://github.com/AlexDenisov/guard-frank/blob/master/locations.png?raw=true).

When you're done, run following commands from project directory

    $ guard init calabash-ios
    $ guard

## Guard options

	all_on_start - run all specs at first start, by default *true*
	device - iphone or ipad, by default *:iphone*

