[![Docker Repository on Quay](https://quay.io/repository/workflow4metabolomics/gie-shiny-heatmap/status "Docker Repository on Quay")](https://quay.io/repository/workflow4metabolomics/gie-shiny-heatmap)

# Heatmap visualization

This repository makes possible to run a Shiny application in a Galaxy Interactive Environment to display Heatmap from a dataMatrix tabular file. We use [d3heatmap](https://github.com/rstudio/d3heatmap) using d3.js and htmlwidgets for the visualization.

## Context

* Using the [Docker Shiny Container](https://github.com/workflow4metabolomics/gie-shiny) to build Shiny GIE.

## Features

* Center and scale data
* Range between 0 and 1
* Choose dissimilarity method
* Choose agglomeration method
* Download heatmap (html file)

## Visualization

![gie-shiny-heatmap](https://github.com/workflow4metabolomics/gie-shiny-heatmap/blob/master/static/images/gie-shiny-heatmap-16-01-19.png)