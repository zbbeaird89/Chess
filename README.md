# Command Line Chess

This is a Chess game that can be played from the command line by 2 players. Each player will have
a turn to move a piece. Moving pieces follows chess notation(A1-H8). To move a piece, type the square the piece is on (e2) to the square you want to move to (e4). The game can be saved or loaded
at any time. Just type 'S' to save and 'L' to load.

## Getting Started

To run the game:

```
git clone https://github.com/zbbeaird89/Chess.git
cd Chess
ruby script/script.rb
```

## Running the tests

To run the entire test suite type:
```
rake
```

To run a specific spec file type:

```
rspec spec/filename_spec.rb
```

## Author

* **Zach Beaird**

## Acknowledgments

* This project is part of the curriculum at [The Odin Project](https://www.theodinproject.com/lessons/ruby-final-project)
* Thank you to the contributors over at [Pry](https://github.com/pry/pry). The debugger tool
saved me so much time and headaches.
