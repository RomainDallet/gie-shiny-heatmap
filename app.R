# Librairies ----
library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(d3heatmap)
library(RColorBrewer)
library(BBmisc)

# Import dataset ----
data_table <- t(as.matrix(read.table("inputdata.tsv", header=TRUE, check.names=FALSE, row.names=1, sep="\t")))

# User interface ----
ui <- dashboardPage(
	dashboardHeader(title="Shiny Heatmap"),
	dashboardSidebar(
		fluidRow(
			# Center & Scale
			h5(strong("Center and scale :")),
			switchInput(
				inputId = "scale",
				label = "Scale",
				value = TRUE,
				onLabel = "YES",
				offLabel = "NO"
			)
		),
		fluidRow(
			# Range
			h5(strong("Range between 0 an 1 :")),
			switchInput(
				inputId = "range",
				label = "Range",
				value = FALSE,
				onLabel = "YES",
				offLabel = "NO"
			)
		),
		hr(),
		fluidRow(
			# Dissimilarity method
			selectInput(
				inputId = "dsmlrt",
				label = "Dissimilarity method :",
				choices = c("euclidean","maximum","manhattan","canberra","binary","minkowski","1-correlation","1-abs(correlation)"),  # + binary ne marche pas
				selected = "euclidean"
			)
		),
		fluidRow(
			conditionalPanel(
				condition = "input.dsmlrt == '1-correlation' || input.dsmlrt == '1-abs(correlation)'",
				# Correlation Method
				selectInput(
					inputId = "cor",
					label = "Correlation Method :",
					choices = c("pearson","spearman","kendall"),
					selected = "pearson"
				)
			)
		),
		fluidRow(
			# Agglomeration method
			selectInput(
				inputId = "agglo",
				label = "Agglomeration method :",
				choices = c("ward.D","single","complete","average","mcquitty","median","centroid"),
				selected = "ward.D"
			)	
		)
	),
	dashboardBody(
		includeCSS("styles.css"),
		fluidRow(
			column(4,
				numericInput(
					inputId = "krow",
					label = "Number of sample clusters to identify :",
					value = 1,
					min = 1,
					max = 10,
					step = 1
				)
			),
			column(4,
				numericInput(
					inputId = "kcol",
					label = "Number of variable clusters to identify :",
					value = 1,
					min = 1,
					max = 10,
					step = 1
				)
			),
			column(4,
				# Color palette
				selectInput(
					inputId = "color",
					label = "Color palette :",
					choices = c("Blues","YellowBlue",RedBlue="RdYlBu"),
					selected = "RedBlue"
				)			
			)
		),
	    fluidRow(
			d3heatmapOutput('HEATMAP_d3')
	    )
	)
)

# Server logic ----
server <- function(input, output) {

    output$HEATMAP_d3 <- renderD3heatmap({

    	if(input$dsmlrt %in% c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski")) {
			hcl_row <- hclust(dist(data_table, method = input$dsmlrt), method = input$agglo)
			hcl_col <- hclust(dist(t(data_table), method = input$dsmlrt), method = input$agglo)
		} else if(input$dsmlrt == "1-correlation") {
			hcl_row <- hclust(as.dist(1-cor(t(data_table), method = input$cor, use = "pairwise.complete.obs")), method = input$agglo)
			hcl_col <- hclust(as.dist(1-cor(data_table, method = input$cor, use = "pairwise.complete.obs")), method = input$agglo)
		} else if(input$dsmlrt == "1-abs(correlation)") {
			hcl_row <- hclust(as.dist(1-abs(cor(t(data_table), method = input$cor, use = "pairwise.complete.obs"))), method = input$agglo)
			hcl_col <- hclust(as.dist(1-abs(cor(data_table, method = input$cor, use = "pairwise.complete.obs"))), method = input$agglo)
		}

		if(input$scale){
			data_table <- scale(data_table, center = TRUE, scale = TRUE)
		}

		if(input$range){
			data_table <- normalize(data_table, method="range")
		}

		if(input$color == "YellowBlue"){
			color_palette <- c("#FFCE00","#FFFFFF","#6B8BA3")
		} else {
			color_palette <- input$color
		}

		graph_d3 <- d3heatmap(data_table, scale = "none", Rowv = as.dendrogram(hcl_row), Colv = as.dendrogram(hcl_col), dendrogram = "both", k_row = input$krow, k_col = input$kcol, colors = color_palette) #input$color)
		
		return(graph_d3)
    })
}

# Run app ----
shinyApp(ui, server)