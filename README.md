# Summary

Develop an api that moves a rover around on a grid. Rules:

- You are given the initial starting point (0,0,N) of a rover.
- 0,0 are X,Y co-ordinates on a grid of (10,10).
- N is the direction it is facing (i.e. N,S,E,W).
- L and R allow the rover to rotate left and right.
- M allows the rover to move one point in the current direction.
- The rover receives a char array of commands e.g. RMMLM and returns the finishing point after the moves e.g. 2,1,N
- The rover wraps around if it reaches the end of the grid.
- The grid may have obstacles. If a given sequence of commands encounters an obstacle, the rover moves up to the last possible point and reports the obstacle e.g. O,2,2,N

# Running the tests

For running the tests provided, you will need the Minitest gem. Open a
terminal window and run the following command to install minitest:

```
gem install minitest
```

You can use rake to simplify how you run tests. If you don't have Rake installed run:

```
gem install rake
```

And then you can run all tests with:

```
rake test
```

In order to run a single test file execute:

```
rake test path/to/file.rb
```