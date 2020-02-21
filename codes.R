install.packages("read.dbc")

library(read.dbc)

estado = ("AC") # pode-se utilizar + de 1 estado, ex: c("SP","MG")
ano = as.character(13:19) #2013 até 2019
# o mes precisa ser nesse formato, usar o as.character é mais inteligente porem não gera o zero da esquerda
mes = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
# local dos dados
pathfile = "/Arquivos/documentos/PS/Dados/"
# local para salvar os dados processados
proc = "/Arquivos/documentos/PS/Proc/"

for(i in estado){
  for(j in ano){
    for(k in mes){
      # o PS deve ser alterado de acordo com o tipo do dado
      inputfile = paste(pathfile, "PS", i, j, k, ".dbc", sep="")
      
      data = read.dbc(inputfile)
      #### filtros de interesse, caso precise de todos os dados retire essa parte
      attach(data)
      
      data <- data.frame(CNES_EXEC, UFMUN, IDADEPAC, SEXOPAC, RACACOR, MUNPAC, LOC_REALIZ, QTDATE, CIDPRI, CIDASSOC)
      
      data <- data[CIDPRI == "F840",]
      #####
      outputfile = paste(proc, i, j, k, ".csv", sep="")
      
      write.csv(data, outputfile, sep="\t", append=F, quote=F, row.names=F)
    }
  }
}

files  <- list.files(path = proc, pattern = '\\.csv', full.names = T)

tables <- lapply(files, read.csv, header = TRUE)

AP <- do.call(rbind, tables)

write.csv(AP, file = "/run/media/gabrielb/Gabriel/Arquivos/documentos/PS/AP.csv", row.names=F)
