<!--[![Docker Repository on Quay](https://quay.io/repository/workflow4metabolomics/gie-shiny-chromato/status "Docker Repository on Quay")](https://quay.io/repository/workflow4metabolomics/gie-shiny-chromato)-->

# Heatmap visualization (In Progress)

This repository makes possible to run a Shiny application in a Galaxy Interactive Environment to display Heatmap from a dataMatrix tabular file. Currently, we try 2 different packages for the visualization, [d3heatmap](https://github.com/rstudio/d3heatmap) using d3.js and htmlwidgets, and [heatmaply](https://github.com/talgalili/heatmaply) based on ggplot2 and plotly.js.

## Context

* Using the [Docker Shiny Container](https://github.com/workflow4metabolomics/gie-shiny) to build Shiny GIE.

## Visualization

Temporary visualizations:

- d3heatmap :

![gie-shiny-heatmap-d3](https://github.com/RomainDallet/gie-shiny-heatmap/blob/master/static/images/gie-shiny-heatmap-d3.png)

- heatmaply :

![gie-shiny-heatmap-plotly](https://github.com/RomainDallet/gie-shiny-heatmap/blob/master/static/images/gie-shiny-heatmap-plotly.png)

