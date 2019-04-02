# Setup

## Installation

Double-click on the `R-ClassicBooks.Rproj` in the root folder of the project. This will open RStudio.

In the `R console` in RStudio run the following command to install all of the needed R packages.

`> packrat::restore()`

## Verify Setup

In order to verify that everything is setup correctly, run the following commands from the `R console` in RStudio, which should show you the failing tests. This is good! We'll be fixing these tests once we jump into the build step.

```
> source('run_tests.R')
> test()
```

Every time you want to check your work locally you can type `test()` in the `R console`, and it will report the status of every task in that module.
As you move through the modules, you can run module-specific tests with `test('module1')`, replacing the number with the one that corresponds to the desired module.

## Previewing Your Work

In order to see your work, you can click the `source` button at the top right of the RStudio editor window. data frames can be viewed in the top right and any plots will show in the bottom right.

# Module 01 - Plotting Charles Dickens' Writing Statistics

## 1.1 - Require readr package

Project Overview
-----
In this module we'll create a visualization that presents data about Charles Dickens' literary works. 

The dataset provided for this module is separated into two csv files. One called 'titles.csv' and the other called 'stats.csv'. 

Each file was created using data compiled from Project Gutenberg. There is a common column between the datasets, the Project Gutenberg ebook `id`, which we will use to join the two csv files together. 

We will filter this data to only include Dickens' work and then plot it using the ggplot2 package.

We will use the tidyverse collection of package. For more on the tidy verse and it's opinionated design philosophy, grammar, and data structures see here: [Tidyverse](https://www.tidyverse.org/).

First Task
---
Open the file called `data.R` that is located in the root folder of the project. Require the `readr` package.

## 1.2 - Read the titles data

The `readr` package from tidyverse includes several functions to import and work with rectangular data. Find the appropriate function to import the css file located at the path `data/titles.csv`. Save the resulting data frame as `titles`.

## 1.4 - Read the stats data

Now that you have the `titles.csv` data imported, import the `data/stats.csv` file as well. Assign the resulting data frame to a `stats` variable.

## 1.5 - Join titles and stats

If you view the `titles` and `stats` data frames, in the upper right of RStudio, you will notice that both have a column called `id`. To align the titles, and author information with the correct stats we need  to merge the `titles` and `stats` data frames into one data frame. 

The `dplyr` package has several functions to join two data frames together. Require the `dplyr` package in `data.R`  and then switch back to `time.R`. Use the appropriate function to join them. *Note: Each data set has the same number of records. They also have identical `id`s.* 

Save the resulting data frame as `books`.

## 1.6 - Requiring a File
In our plot for this module we would like to show certain statistics about Charles Dickens' books over time. We will prepare the data and create this plot in a new file.

Open the file called `time.R`. Since we are in a new file we need access to the `books` data frame from `data.R`. Use the `source()` function to import the `data.R` file. 

## 1.7 - Find Dickens' Works

For our plot we are only concerned about Charles Dickens' works. In `time.R`, using functions from the `dplyr` package create a data frame that only contains books written by Dickens. Call the new data frame `dickens`.

*Note: If you use `str_detect()` from the `stringr` package you will need to require it first in `data.R`.*

## 1.8 - Refining Columns

Still in `time.R`, refine the columns of the `dickens` data frame with a pipe and `select()` function. We only want the columns: `id`, `words`, `sentences`, `to_be_verbs`, `contractions`, `pauses`, `cliches`, and `similes`. The resulting data frame should again be called `dickens`.

## 1.9 - Importing Year Published
Since the plot we are creating is about Charles Dickens' writing statistics over time we need to have the year each work was published. Neither dataset that we have imported so far contains the year of publication. 

This information is in the file `data/published.csv`. Import this new file and call the resulting data frame `published`.

## 1.10 - Joining year published
The `published` data frame should now contain the `id` and `year` for all of Dickens' works. Join the `published` and `dickens` data frames, call the resulting data frame `time`.

## 1.11 - Reshaping data frames
The `time` data frame now looks like this:

[[IMAGE]]

This data frame has several columns, creating a shape that is referred to as wide. This wide format or shape does not lend itself well to the type of plot we are creating. We need a data frame that has a long format or shape. 

The process of converting data frames between wide and long is a common operation and can be done with functions like [`gather()`](https://tidyr.tidyverse.org/reference/gather.html) and [`spread()`](https://tidyr.tidyverse.org/reference/spread.html) from the `tidyr` package.

Require the `tidyr` package in the `data.R` file, then switch back to `time.R` and use the proper function to convert our wide data frame to a long data frame. Save the new long form data frame as `time`. The columns that should be reshaped are `words` through `similes`.

## 1.12 - Creating a Line Plot
For plotting the `time` data frame, open `data.R` and require the `ggplot2` package below the existing packages. 

Switch back to `time.R` and call the `ggplot()` function below the existing code. 

Create a line plot by adding (+) `geom_line()` to `ggplot()`.  

## 1.13 Plot Configuration
Pass the correct values to the `ggplot()` function, so x-axis should be the `year`. The y-axis should be the `value` or the `count` of the particular type of item that `year`. The legend(`color`) should be the `key` or `type`.  **Hint: You will need to use the `aes()` function.**
