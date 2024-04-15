# Instale os pacotes necessários
install.packages("pdftools")
install.packages("openxlsx")
install.packages("xlsx")

remove.packages("openxlsx")

# Carregue os pacotes
library(pdftools)
library(openxlsx)
library(xlsx)

# Caminho para o arquivo PDF do cartão de ponto
caminho_pdf <- "../Test_PJ//C_P_teste.pdf"

# Extraia o texto do PDF
texto_pdf <- pdf_text(caminho_pdf)

# Exiba o texto extraído (opcional)
cat(texto_pdf)

# Processamento do texto e extração das entradas e saídas
# Aqui você precisaria implementar a lógica para extrair as informações relevantes

--------------------------------------------------------------------
  
# Exemplo de dados de entrada e saída
seus_dados_de_entrada <- c("07:00")  # Exemplo de horários de entrada
seus_dados_de_saida <- c("12:00")     # Exemplo de horários de saída

# Criar um dataframe com os dados
dados <- data.frame(
  Ocorrência = c("01/04/2024", "02/04/2024", "03/04/2024", "04/04/2024", "05/04/2024", "06/04/2024", "07/04/2024"),
  Semana = c("Segunda-feira", "Terça-fera", "Quarta-feira","Quinta-feira", "Sexta-feira", "Sábado", "Domingo"),
  Entrada = c("07:00"),
  Saída = c("12:00"),
  Entrada2 = c("13:00"),
  Saída2 = c("18:00")
)

# Exemplo de extração de entradas e saídas
# Exemplo de extração de entradas e saídas
ocorrência <- subset(dados, Ocorrência %in% c("01/04/2024", "02/04/2024", "03/04/2024", "04/04/2024", "05/04/2024", "06/04/2024", "07/04/2024"))$Ocorrência
semana <- subset(dados, Semana %in% c("Segunda-feira", "Terça-feira", "Quarta-feira","Quinta-feira", "Sexta-feira", "Sábado", "Domingo"))$Semana
entradas <- subset(dados, Entrada == "07:00")$Entrada
saídas <- subset(dados, Saída == "12:00")$Saída
entradas2 <- subset(dados, Entrada2 == "13:00")$Entrada2
saídas2 <- subset(dados, Saída2 == "18:00")$Saída2

# Exiba as entradas e saídas (opcional)
print(entradas)
print(saídas)

# Abra a planilha do Excel
wb <- loadWorkbook("../Test_PJ//Test_PJ.xlsx")

# Selecione a folha e a célula onde deseja inserir os dados
# Suponha que você queira inserir os dados na primeira coluna, começando na segunda linha
addWorksheet(wb, "Test")  # Nome da sua planilha ou folha

#Escreva os nomes das colunas 
writeData(wb, "Test", colnames(dados), startCol = 1, startRow = 1)

# Escreva os dados nas planilhas
writeData(wb, "Test", dados$Ocorrência, startCol = 1, startRow = 2)
writeData(wb, "Test", dados$Semana, startCol = 2, startRow = 2)
writeData(wb, "Test", dados$Entrada, startCol = 3, startRow = 2)
writeData(wb, "Test", dados$Saída, startCol = 4, startRow = 2)
writeData(wb, "Test", dados$Entrada2, startCol = 5, startRow = 2)
writeData(wb, "Test", dados$Saída2, startCol = 6, startRow = 2)

--------------------------------------------------------------------
  
# Salve a planilha atualizada
saveWorkbook(wb, file = "../Test_PJ//Test_PJ.xlsx", overwrite = TRUE)


#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
  

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

# Imprimir os dados extraídos
print(dados)

# Abra a planilha do Excel
wb <- createWorkbook()

# Adicione uma nova planilha
addWorksheet(wb, "Planilha1")

# Escreva cada coluna em células separadas
for (i in 1:ncol(dados)) {
  print(paste("Escrevendo coluna", i, "na planilha..."))
  writeData(wb, "Planilha1", dados[, i], startCol = i, startRow = 1)
}

# Salve a planilha
saveWorkbook(wb, "../Test_PJ//Test_PJ.xlsx", overwrite = TRUE)

  
  
  
  
  
  


  
  
  
  
  
  
  
  