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
		conditionalPanel(
			condition = "input.choice == false",
			plotlyOutput('HEATMAP_plotly')
		),
		conditionalPanel(
			condition = "input.choice == true", 
			d3heatmapOutput('HEATMAP_d3')
		)
    ),
	fluidRow(
		column(4,
			h5(strong("Wich package :")),
			switchInput(
				inputId = "choice",
				label = strong("Package"),
				value = FALSE,
				offLabel = "Heatmaply",
				onLabel = "D3heatmap"
	        )
		),
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
		)
	)
)

# Server logic ----
server <- function(input, output) {

	# dendrogram = "both", k_row = nb_row
    output$HEATMAP_plotly <- renderPlotly({
        graph_plotly <- heatmaply(data_table, scale = "column", dendrogram = "both", k_row = input$krow, k_col = input$kcol, colors = Spectral(20)) 
        return(graph_plotly)
    })

    output$HEATMAP_d3 <- renderD3heatmap({
		graph_d3 <- d3heatmap(data_table, scale = "column", dendrogram = "both", k_row = input$krow, k_col = input$kcol, colors = Spectral(20))
        return(graph_d3)
    })
}

# Run app ----
shinyApp(ui, server)
