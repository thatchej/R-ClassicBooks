# Build Visualizations of Classic Literature with R - DRAFT

## Setup

### Installation

Double-click on the `R-ClassicBooks.Rproj` in the root folder of the project. This will open RStudio.

In the `R console` in RStudio run the following command to install all of the needed R packages.

`> packrat::restore()`

### Verify Setup

In order to verify that everything is setup correctly, run the following commands from the `R console` in RStudio, which should show you the failing tests. This is good! We'll be fixing these tests once we jump into the build step.

```
> source('run_tests.R')
> test()
```

Every time you want to check your work locally you can type `test()` in the `R console`, and it will report the status of every task in that module.
As you move through the modules, you can run module-specific tests with `test('module1')`, replacing the number with the one that corresponds to the desired module.

### Previewing Your Work

In order to see your work, you can click the `source` button at the top right of the RStudio editor window. DataFrames can be viewed in the top right and any plots will show in the bottom right.
