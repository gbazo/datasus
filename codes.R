install.packages("read.dbc")

library(read.dbc)

for(i in estado){
  for(j in ano){
    for(k in mes){
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
