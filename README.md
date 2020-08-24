# Elmgorithm
Browser based visualization of sorting algorithms using [Elm](https://elm-lang.org/).

## Visualized algorithms
All of the visualized algorithms are implemented recursivly.

* Bubble Sort
* Insertion Sort
* Merge Sort
* Quick Sort

## How to start
Elmgorithm was developed using the interactive development tool `elm-reactor`.
You can download and start the app by executing the following commands.

```
$ git clone https://github.com/Kluddizz/elmgorithm
$ cd elmgorithm
$ elm reactor
```
This will start a local server (on port 8000 by default). Now, the app is
accessible visiting `http://localhost:8000/src/Main.elm`.

## How to use
### Overview

### 1. Choose an algorithm 
In the settings click the dropdown menu and select an algorithm. You can read more
about the implementation and performance by clicking the question mark next to
the input field.

### 2. Insert a number of elements
In the settings select the input field labeled with 'Elements' and enter the
number of elements inside the list, which will be sorted and animated.

### 3. Generate random elements
In the settings you can generate new elements of the list using the "New
Values" button.

### 4. Calculate and play the animation
In the setting you can start the calculation of the selected algorithm and play
the animation using the play button.

### 5. Watch the statistics and change the animation speed
While the animation is running you can observe some statistical information
about it above the animation display.
