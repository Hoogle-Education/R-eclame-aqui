################
### Original ###
################
library(RSelenium)
library(tidyverse)


system("taskkill /im java.exe /f",
       intern = FALSE, ignore.stdout = FALSE)

# do not remove chrome version
# nao esquecer de iniciar o chrome driver

driver1 <- rsDriver(browser = "chrome",
                    port = 9515L,
                    chromever = "102.0.5005.61")

driver2 <- rsDriver(browser = "chrome",
                    port = 9517L,
                    chromever = "102.0.5005.61")


remote_driver1 <- driver1$client
remote_driver2 <- driver2$client

remote_driver1$open()
remote_driver2$open()

# loop
for (num_pagina in 1:150) {
    url1 <- paste0("https://www.reclameaqui.com.br/",
                "empresa/vagas-com/lista-reclamacoes/",
                "?pagina=",
                2 * num_pagina - 1)

    url2 <- paste0("https://www.reclameaqui.com.br/",
                "empresa/vagas-com/lista-reclamacoes/",
                "?pagina=",
                2*num_pagina) 
    
    remote_driver1$navigate(url1) 
    remote_driver2$navigate(url2) 
  
    webElement <- remote_driver1$findElements(  
      using = "class name", value = "fTrwHU")
    
    webElement[[1]]$clickElement
    
  
    # webElement <- remote_driver1$findElements(using = "xpath",
                            #  value = c("//*[@id='__next']/div[1]/div[1]/",
                             #           "div[3]/main/div/div[2]/div[1]/div/",
                              #          "div[3]/div[1]/div[1]/div[1]/span") )
  
  Sys.sleep(2) 
}

remote_driver1$close()
remote_driver2$close()

###########################################################

# using -> escolher o campo do html || value -> valor do campo a ser buscado 


vetor <- c(1, 2, 3, 4)

# loop
for(i in 1:4){
  vetor[i] <- vetor[i] + 1
}

# enquanto
while (length(founded) != 0) {
  
  unique()
}
