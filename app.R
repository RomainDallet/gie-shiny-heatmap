# Librairies ----
library(shiny)
library(shinyWidgets)
library(d3heatmap)
library(heatmaply)
library(RColorBrewer)


# Import dataset ----
data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))


# User interface ----
ui <- fluidPage(
	includeCSS("styles.css"),
    fluidRow(
		d3heatmapOutput('HEATMAP_d3')
    ),
	fluidRow(
		column(4,
			numericInput(
				inputId = "krow",
				label = "k row :",
				value = 3,
				min = 1,
				max = 10,
				step = 1
			)
		),
		column(4,
			numericInput(
				inputId = "kcol",
				label = "k col :",
				value = 3,
				min = 1,
				max = 10,
				step = 1
			)
		),
		column(4) # Normalisation ou non ?
	)
)

# Server logic ----
server <- function(input, output) {

    output$HEATMAP_d3 <- renderD3heatmap({
		graph_d3 <- d3heatmap(normalize(data_table), scale = "column", dendrogram = "both", k_row = input$krow, k_col = input$kcol, colors = Spectral(20))
        return(graph_d3)
    })

}

# Run app ----
shinyApp(ui, server)
