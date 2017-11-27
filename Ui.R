library(plotly)
library(shiny)
library(shinyjs)
shinyUI(fluidPage(
  useShinyjs(),
  navbarPage("Bills",
            tabPanel("Bill",
                       column(4,wellPanel( div(id="form",
                      helpText("Enter Bill"),dateInput("dateid", "Date:", value = Sys.Date(),format = "dd-mm-yyyy"),
             textInput("Item","Item"),
             selectInput("Cat", "Cat:",
                         c("Food"="Food","Clothing"="Clothing","Electronics"="Electronics","Kitchen"="Kitchen","HouseAssc"="HouseAssc","Travel"="Travel",
                           "Medicine"="Medicine","Stationery"="Stationery","Uni"="Uni","Other"="Other"
                         )),
             textInput("Cost","Cost")
             ),
             actionButton("Add","Add"),
             actionButton("Clear","Clear")
             )),
             
             column(4,wellPanel(
              helpText("Update Bill"),
            tabsetPanel(
              tabPanel("Update",div(id="form1",textInput("Rownum","Enter RowNum"),
                       selectInput("Select","Select",
                                   c("Date"="ChangDate","Item"="ChangeItem","Cost"="ChangCost","Cat"="Changecat"                           
                                   )
                       )
                       ,
                       uiOutput("ui"),
                       actionButton("Update","Update"),
                       actionButton("Reset","Reset")
                       )),
              tabPanel("Delete",div(id="form2",textInput("Row","Enter Rownum "),
                       actionButton("Delete","Delete"),
                       actionButton("Reset1","Reset")
              ))
            )
             ))
             )
              ,tabPanel("Stats",
                      
                      sidebarLayout(
                        sidebarPanel( 
                          conditionalPanel(
                            
                          'input.dataview==="Table" ',
                          radioButtons("Grouby", " GroupBy:",
                                             c("Month" = "month",
                                              "Day"="day",
                                              "Year"="year",
                                               "Item" = "item",
                                               "Total"="total",
                                               "monthitem"="monthitem",
                                                "monthcat"="monthcat",
                                                "itemyear"="itemyear",
                                                "month_cat_item"="month_cat_item",
                                                "year_cat_item"="year_cat_item"
                                               ),selected="total"),
                          actionButton("Modify","Modify"),
                          downloadLink('download','download')),
                          conditionalPanel(
                            
                            'input.dataview==="PIE"',
                            numericInput("YEAR","Choose Year:",min=2017,value=2017),
                            radioButtons("Pie","Pie:",
                                         c("CatYear"="CatYear",
                                           "CatMon"="CatMon"
                                           )),
                            numericInput("MONTH","Choose Month:",min=1,value=1,max=12)
                          
                            ),
                          conditionalPanel('input.dataview==="Analysis"' ,
                                           
                                           numericInput("YEAR1","Choose Year:",min=2017,value=2017),
                            radioButtons("Pie1","Select:",
                                           c("CatYearA"="CatYearA",
                                           "CatMonA"="CatMonA",
                                           "YearA"="YearA"
                                           )),
                                           numericInput("MONTH1","Choose Month:",min=1,value=1,max=12),
                            
                                           helpText("Check the Viewer pane in Rstudio")
                                           )
                      ),
                      mainPanel(
                      tabsetPanel(
                         id='dataview',
                         tabPanel( "Table", DT::dataTableOutput("mytable2")),
                          tabPanel("PIE",plotOutput("PiePlot")),
                         tabPanel("Analysis",plotlyOutput("Analysys"))
                          
                         )))
                      ),
             
             
             tabPanel("View",
                      sidebarLayout(
                        sidebarPanel(
                          helpText("you can check your wages here"),
                          actionButton("Refresh","Refresh")
                          )
                        ,
                        mainPanel(
                            id = 'dataset',
                            DT::dataTableOutput("mytable1")
                            )
                            
                        
                        )
                      
                      )
             
             ) 
  
))
