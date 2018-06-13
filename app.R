# Librairies ----
library(shiny)
library(d3heatmap)

# Import dataset ----
data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))


# User interface ----
ui <- fluidPage(
        fluidRow(
                d3heatmapOutput('HEATMAP')
        )
)

# Server logic ----
server <- function(input, output) {
        output$HEATMAP <- renderD3heatmap({
                graph <- d3heatmap(data_table, scale = "column", dendrogram = "row", k_row = 3)
                return(graph)
        })
}

# Run app ----
shinyApp(ui, server)
