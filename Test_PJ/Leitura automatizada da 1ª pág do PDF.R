# Instale os pacotes necessários
install.packages("pdftools")
install.packages("openxlsx")

# Carregue os pacotes
library(pdftools)
library(openxlsx)
remove.packages("openxlsx")

# Caminho para o arquivo PDF do cartão de ponto
caminho_pdf <- "../Test_PJ//C_P_teste.pdf"  # Substitua pelo caminho correto para o seu arquivo PDF

# Extraia o texto do PDF
texto_pdf <- pdf_text(caminho_pdf)

# Processamento do texto e extração dos dados
# Aqui você precisaria implementar a lógica para extrair as informações relevantes

# Função para extrair os dados entre a primeira e a última linha do PDF
extrair_dados <- function(texto) {
  # Divida o texto em linhas
  linhas <- strsplit(texto, "\n")[[1]]
  
  # Inicialize uma lista para armazenar os dados de cada linha
  dados <- list()
  
  # Loop sobre as linhas para extrair os dados
  for (i in 1:length(linhas)) {
    linha <- linhas[i]
    
    # Divida a linha em colunas (supondo que as colunas são separadas por espaço em branco)
    colunas <- unlist(strsplit(linha, "\n"))  # Separadas por um ou mais espaços em branco
    
    # Adicione as colunas à lista de dados
    dados[[i]] <- colunas
  }
  
  # Converta a lista de dados em um dataframe
  dados_df <- as.data.frame(do.call(rbind, dados))
  
  # Retorne o dataframe de dados
  return(dados_df)
}

# Extrair os dados entre a primeira e a última linha do PDF
dados <- extrair_dados(texto_pdf)

print(dados)
# Carregue o pacote openxlsx
library(openxlsx)

# Abra a planilha do Excel
wb <- createWorkbook()

# Adicione uma nova planilha
addWorksheet(wb, "Colunas")

# Escreva cada coluna em células separadas e defina o estilo de célula para centralizar o conteúdo
for (i in 1:ncol(dados)) {
  print(paste("Escrevendo coluna", i, "na planilha..."))
  writeData(wb, "Colunas", dados[, i], startCol = i, startRow = 1)
  addStyle(wb, "Colunas", rows = 1:(nrow(dados) + 1), cols = i, style = createStyle(textDecoration = "bold"), gridExpand = TRUE)
  setColWidths(wb, "Colunas", cols = i, widths = "auto")
}


# Salve a planilha
saveWorkbook(wb, "../Test_PJ//Test_PJ.xlsx", overwrite = TRUE)

print(dados)

rm(list = ls())
