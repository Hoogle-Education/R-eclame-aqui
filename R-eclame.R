
###########################################################
# FUNÇÕES

# inicializa <- function( ) {
#   
#   # limpa as variaveis
#   rm(list=ls()) 
#   
#   # bibliotecas
#   library(RSelenium)
#   library(tidyverse)
#   
#   
#   # finaliza processos abertos antigos
#   system("taskkill /im java.exe /f",
#          intern = FALSE, ignore.stdout = FALSE)
#   
#   # sincronize a versao do chrome com seu webdriver
#   driver <- rsDriver(browser = "chrome",
#                      port = 9515L,
#                      chromever = "102.0.5005.61")
#   
#   
#   # abre o driver
#   remote_driver <- driver$client
#   remote_driver$open() 
#   
#   return  remote_driver
# }

# xpath_string <- function(anchor_tag_number) {
#   
# }

###########################################################

# PROCEDIMENTOS

# bibliotecas
library(RSelenium)
library(tidyverse)


# finaliza processos abertos antigos
system("taskkill /im java.exe /f",
       intern = FALSE, ignore.stdout = FALSE)

# sincronize a versao do chrome com seu webdriver
driver <- rsDriver(browser = "chrome",
                   port = 9515L,
                   chromever = "102.0.5005.61")


# abre o driver
remote_driver <- driver$client
remote_driver$open(silent=TRUE) 

num_pagina <- 1

# começando sempre na pagina 1
url <- paste0("https://www.reclameaqui.com.br/",
              "empresa/vagas-com/lista-reclamacoes/",
              "?pagina=1")

remote_driver$navigate(url)


# extraindo o numero da ultima pagina
# só funciona com a aba de inspect aberta
# 
webElement <- remote_driver$findElements(
  value = "/html/body/div[1]/div[1]/div[1]/div[2]/main/section[2]/div[2]/div[2]/div[11]/ul/li[8]"
)

num_ultima_pagina <- webElement[[1]]$getElementText()
num_ultima_pagina <- as.numeric(num_ultima_pagina)
num_ultima_pagina

textos <- c()
datas <- c()
locais <- c()


# loop
for (num_pagina in 1:num_ultima_pagina) {
    
  url <- paste0("https://www.reclameaqui.com.br/",
                "empresa/vagas-com/lista-reclamacoes/",
                "?pagina=",
                num_pagina)
  
  remote_driver$navigate(url) 
  
  
  # div_elements <- remote_driver$findElements(using = "class name", value = "bJdtis")
  #   
  # numero_de_reclamacoes <- length(div_elements)
  
  
  for(numero_da_achor_tag in 1:10) {
    extrai(numero_da_achor_tag)
  }
  
  df <- data.frame("Local" = locais, "Data" = datas, "Texto" = texto, stringsAsFactors = FALSE)
  df
  
  # construo o caminho até o link
  
    # webElement <- remote_driver1$findElements(using = "xpath",
                            #  value = c("//*[@id='__next']/div[1]/div[1]/",
                             #           "div[3]/main/div/div[2]/div[1]/div/",
                              #          "div[3]/div[1]/div[1]/div[1]/span") 
  Sys.sleep(5) 
}

remote_driver$close()

###########################################################


# extraindo dados da reclamacao
extrai <- function(numero_da_achor_tag) {
  
  Sys.sleep(1)
  
  numero_da_achor_tag <- 4
  
  xpath_string <- paste0( "/html/body/div[1]/div[1]/div[1]/div[2]/main/section[2]/div[2]/div[2]/div[",
                          numero_da_achor_tag,
                          "]/a" )
  xpath_string
  
  # encontro os elementos
  webElement2 <- remote_driver$findElements(
    using = 'xpath',
    value = xpath_string
  )
  
  webElement2[[1]]$clickElement()
  
  Sys.sleep(5)
  
  webElement_local <- remote_driver$findElements(value = paste0("/html/body/div[1]/div[1]/div[1]/div[2]/main/div/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/span"))
  local_da_reclamacao <- webElement_local[[1]]$getElementText()
  
  webElement_data <- remote_driver$findElements(value = paste0("/html/body/div[1]/div[1]/div[1]/div[2]/main/div/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[2]/span"))
  data <- webElement_data[[1]]$getElementText()
  
  webElement_texto <- remote_driver$findElements(value = paste0("/html/body/div[1]/div[1]/div[1]/div[2]/main/div/div[1]/div[1]/div[1]/div[3]/p"))
  texto <- webElement_texto[[1]]$getElementText()
  
  remote_driver$goBack()
  
  Sys.sleep(2)
  textos <- c(textos, texto)
  locais <- c(locais, local_da_reclamacao)
  datas <- c(datas, data)
}



