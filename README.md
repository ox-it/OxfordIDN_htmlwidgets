# About this repository

This repository was initially created to provide how-to-guides on using htmlwidgets for interactive data visualisations by the [Live Data Project](http://blogs.it.ox.ac.uk/acit-rs-team/projects/live-data-project) team. Note that an interactive version of this document is avialable here: http://ox-it.github.io/LiveData_htmlwidgets/  

# Interactive Chart with htmlwidgets

The interactive web is built on JavaScript, from interactive bar charts to the interactive maps provided by Google, Bing and other services. There is a relatively simple way to build these interactive charts directly from R and to host these online via RPubs, GitHub Pages or to include such interactive data visualisations within a Shiny app - htmlwidgets.

In order to generate these charts, R must generate the requisite HTML and JavaScript code for the visualisations. The RStudio company has made this process easy by developing a library called `htmlwidgets` which acts as a framework for building JavaScript bindings - which simply means: 

> htmlwidgets provides standardised tools to build secondary R packages that bind to JavaScript libraries, the functions in these R packages can be used to generate the same output the original JavaScript library would

# What's in these guides? 

There are over 15 CRAN-hosted libraries that utilise htmlwidgets for creating interactive content, the majority of these libraries are well documented at <a href="http://www.htmlwidgets.org">htmlwidgets.org</a>. The documentation at htmlwidgets.org is focused on individual libraries, it does not attempt to group them or compare the utility of the different libraries for specific types of charts.

This collection of guides attempts to address the following questions:

- Which library is capable of making chart X?
- Which charts can be made with library X?
- What type of data can be displayed with each chart/library?
- How does the process for creating chart X compare across the available libraries?

Note that these guides were produced for the [Live Data Project](blogs.it.ox.ac.uk/acit-rs-team/projects/live-data-project/) run by Oxford University and do not aim to cover *all* htmlwidgets, in the first place only those libraries used in case studies are covered. However, futurue contributions are welcome.

### Chart Templates

The following chart templates are currently provided:

- [BarCharts](http://ox-it.github.io/LiveData_htmlwidgets/charts/BarCharts), [StackedBarCharts](http://ox-it.github.io/LiveData_htmlwidgets/charts/StackedBarCharts), [LineCharts](http://ox-it.github.io/LiveData_htmlwidgets/charts/LineCharts)
- [Interactive Tables (Datatables)](http://ox-it.github.io/LiveData_htmlwidgets/datatable)
- Gauges
- Scattergeo, Choropleth
- Networks
- Timelines and Gantt Charts

Chart templates are organised in this repository as follows:

```
chartType
---------| index.html
---------| shiny_Folder
-----------------------| ui.R
-----------------------| server.R
```

The index.html file contains a very basic description of the chartType discussed in the templates, and instructions on how to construct the chartType with a variety of different libraries (where possible). This file can be viewed at the following address:

http://ox-it.github.io/LiveData_htmlwidgets/chartType

Where multiple libraries are capable of making comparable visualisations, a shiny app is provided to compare these at the following address:

https://livedataoxford.shinyapps.io/htmlwidget_template_chartType/
