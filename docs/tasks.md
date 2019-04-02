# Setup

## Installation

Double-click on the `R-ClassicBooks.Rproj` in the root folder of the project. This will open RStudio.

The first time you open the project it will automatically install the needed R packages. This install process can take some time. 

Every time that you open the project thereafter the  `packrat::restore()` command will automatically run and update your packages if needed. 

## Verify Setup

In order to verify that everything is setup correctly, run the following command from the `R console` in RStudio.

`> .run$tests()`

This should show you the failing tests. This is good! We'll be fixing these tests once we jump into the build step.

Every time you want to check your work locally you can type `.run$tests()` in the `R console`, and it will report the status of every task in that module.

As you move through the modules, you can run module-specific tests with `.run$tests('module1')`, replacing the number with the one that corresponds to the desired module.

## Previewing Your Work

In order to see your work, you can click the `source` button at the top right of the RStudio editor window. data frames can be viewed in the top right and any plots will show in the bottom right.

# Module 01 - Plotting Charles Dickens' Writing Statistics

## 1.1 - Require the readr package

Project Overview
-----
In this module we'll create a visualization that presents data about Charles Dickens' literary works. 

The dataset provided for this module is separated into two main csv files. One called 'titles.csv' and the other called 'stats.csv'. 

Each file was created using data compiled from Project Gutenberg. There is a common column between the datasets, the Project Gutenberg ebook `id`, which we will use to join the two csv files together. 

We will filter this data to only include Dickens' work and then plot it using the ggplot2 package.

We will use the tidyverse collection of packages. For more on the tidyverse and it's opinionated design philosophy, grammar, and data structures see [Tidyverse](https://www.tidyverse.org/).

First Task
---
Open the file called `data.R` that is located in the root folder of the project. Require the `readr` package.

## 1.2 - Read the titles data

The `readr` package, from tidyverse, includes several functions to import and work with rectangular data. 

Find the appropriate function to import the csv file located at the path `data/titles.csv`. Save the resulting data frame as `titles`.

## 1.3 - Read the stats data

Now that you have the `titles.csv` data imported. Import the `data/stats.csv` file as well. Assign the resulting data frame to a `stats` variable.

## 1.4 - Require the dplyr package

If you view the `titles` and `stats` data frames in the upper right of RStudio, you will notice that both have a column called `id`. We need to combine these two frames into one.

The `dplyr` package has several functions to join two data frames together.

Require the `dplyr` package in `data.R` below the other packages in `data.R`. 

## 1.5 - Join titles and stats
Still in `data.R`, let's align the titles and author information with the correct stats. 

Use the appropriate function from the `dplyr` package to join the `titles` and `stats` data frames into one data frame. *Note: Each data set has the same number of records. They also have an identical set of `id`s.* 

Save the merged data frame as `books`.

[[ IMAGE ]]

## 1.6 - Requiring a File
In this module's plot we would like to show certain statistics about Charles Dickens' works over time. For example, "How many words did he pen in 1870?" 

We will prepare the data and create this plot in a new file.

Open the file called `time.R`. 

In `time.R` we need access to the `books` data frame from `data.R`. Use the `source()` function to import the `data.R` file. 

## 1.7 - Find Dickens' Works

For our plot we are only concerned about Charles Dickens' works. In `time.R`, using functions from the `dplyr` package create a data frame that only contains books written by Dickens. Call the new data frame `dickens`.

*Note: If you use `str_detect()` from the `stringr` package you will need to require it first in `data.R`.*

## 1.8 - Refining Columns

Still in `time.R`, refine the columns of the `dickens` data frame with a pipe and `select()` function. We only want the columns: `id`, `words`, `sentences`, `to_be_verbs`, `contractions`, `pauses`, `cliches`, and `similes`. 

The resulting data frame should again be called `dickens`.

## 1.9 - Importing Year Published
Since the plot we are creating is about Charles Dickens' writing statistics over time we need to have the year each work was published. However, neither dataset contained the year of publication. 

This information is in the file `data/published.csv`. Import this new file in `time.R`, and call the resulting data frame `published`.

## 1.10 - Joining year published
The `published` data frame should now contain the `id` and `year` for all of Dickens' works. Join the `published` and `dickens` data frames, call the resulting data frame `time`.

## 1.11 - Require the tidyr package
The `time` data frame now looks like this:

[[IMAGE]]

This data frame has several columns, creating what is referred to as wide shape. This wide shape does not lend itself well to the type of plot we are creating. We need a data frame that has a long shape. 

The process of converting data frames between wide and long is a common operation and can be done with functions like [`gather()`](https://tidyr.tidyverse.org/reference/gather.html) and [`spread()`](https://tidyr.tidyverse.org/reference/spread.html) from the `tidyr` package.

Switch to the `data.R` file and require the `tidyr` package. 

## 1.12 - Reshaping data frames
Switch to `time.R`, below the existing code, use the proper function to convert our wide data frame to a long data frame. The columns that should be reshaped are `words` through `similes`. Save the new long form data frame as `time`.

[[ IMAGE ]]

## 1.13 - Require the ggplot2 package
For plotting the `time` data frame, open `data.R` and require the `ggplot2` package.

## 1.14 - Construct a Plot
Switch to `time.R`, save a call to the `ggplot()` function in a variable called `p`.

On a new line call the `plot()` function passing in `p`.

## 1.15 - Creating a Line Plot
Create a line plot by adding (+) `geom_line()` to the `ggplot()` call.

## 1.16 - Plot Configuration
Pass the correct values to the `ggplot()` function. These values should be wrapped in a call to the `aes()` function.

- The x-axis should be the `year`.
- The y-axis should be the `count`.
- The color should be the `key`.


