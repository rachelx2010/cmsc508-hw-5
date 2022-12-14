# Homework 5 - CMSC508 - Fall 2022
Why play with toy databases when we can drink from a fire hose!

For this assignment we'll be working with data downloaded from the world bank. These data are only a small part of what's available from their data catalog. My goal for this assignment is to give you some larger data sets to play with while keeping run times of your queries down to a managable level and minimizing the impact on the server hard disk.

Like homework 4, there will be two major files of your making, a DDL file to create your data tables and a DML file for your queries.  These will be submitted for autograding using GITHUB.

I'll provide you with several source CSV files.  These CSV files are subsets of a larger master ZIP file downloaded from the World Bank.  I wrote a series of python scripts to sift through the data and produce CSV files for this assignment. You're welcome to review these scripts to see the earlier stages of the larger data pipeline.

## Data source
We'll be using data downloaded from the World Bank data catalog of [world development Indicators](https://datacatalog.worldbank.org/search/dataset/0037712/World-Development-Indicators).  Specifically, we'll be using the CSV files stored within this [ZIP file](https://databank.worldbank.org/data/download/WDI_csv.zip).

## Tasks for Homework 5

Homework 5 works with a single table.  Yes, you could probably break it into multiples, but that
will be saved for another assignment!

Like homework 4, the DDL and DML files will be broken into sections.  Within each section, I'll ask you to provide SQL code that performs a task that moves the data one step further down a data pipeline.

Follow the instructions in the different files, adding SQL as required and the assignment will walk you through a real-world example of data analysis using SQL.  Most data analysis projects follow the general workflow embedded within this assignment.

## Getting started!

You're well on your way, you're reading this README! Like other projects:
1. Use the invite I send you to create your homework 5 repository on classroom.github.com.
1. Clone the repo in VSCODE and store the repo on your local computer.
1. Like homework 4, we'll be using your personal MySQL data base "202310_users_<eid>"
1. Add your code incrementally to the DDL and the DML files.  You can work with both files at the same time growing your code base in a test-driven fashion, writing your tests (SELECT statements) first, then adding the code to create the tables as you go.
1. When you're ready, visit the gradescope site and and submit your assignment to the autograder.

**NOTE** - Many of you noticed how long the autograder took to run last time, especially right up near the due date! The autograder only processes one assignment at a time, so if a whole bunch of you wait until the last minute to submit your assignments the wait time to get feedback on your assignment will be REALLY LONG!

**Please do not wait to the last minute to complete this assignment!!**
