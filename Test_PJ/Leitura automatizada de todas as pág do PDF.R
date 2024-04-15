
# Caminho para o arquivo PDF do cartão de ponto
caminho_pdf <- "../Test_PJ//C_P_teste.pdf"  # Substitua pelo caminho correto para o seu arquivo PDF

# Extraia o texto de todas as páginas do PDF
texto_pdf <- pdf_text(caminho_pdf)

# Função para extrair os dados de todas as páginas do PDF
extrair_dados_todas_paginas <- function(texto) {
  # Inicialize uma lista para armazenar os dados de todas as páginas
  dados_todas_paginas <- list()
  
  # Loop sobre o texto extraído de cada página
  for (pagina in texto) {
    # Divida o texto da página em linhas
    linhas <- strsplit(pagina, "\n")[[1]]
    
    # Inicialize uma lista para armazenar os dados de cada linha da página
    dados_pagina <- list()
    
    # Loop sobre as linhas para extrair os dados
    for (i in 1:length(linhas)) {
      linha <- linhas[i]
      
      # Divida a linha em colunas (supondo que as colunas são separadas por espaço em branco)
      colunas <- unlist(strsplit(linha, "\n"))  # Separadas por um ou mais espaços em branco
      
      # Adicione as colunas à lista de dados da página
      dados_pagina[[i]] <- colunas
    }
    
    # Converta a lista de dados da página em um dataframe e adicione à lista de dados de todas as páginas
    dados_todas_paginas[[length(dados_todas_paginas) + 1]] <- as.data.frame(do.call(rbind, dados_pagina))
  }
  
  # Retorne a lista de dataframes de todas as páginas
  return(dados_todas_paginas)
}

# Extrair os dados de todas as páginas do PDF
dados_todas_paginas <- extrair_dados_todas_paginas(texto_pdf)

# Carregar o pacote openxlsx
library(openxlsx)

# Criar um novo arquivo Excel
wb <- createWorkbook()

# Para cada página, criar uma nova planilha e escrever os dados nela
for (i in 1:length(dados_todas_paginas)) {
  addWorksheet(wb, paste0("Página_", i))
  writeData(wb, paste0("Página_", i), dados_todas_paginas[[i]])
}

# Salvar o arquivo Excel
saveWorkbook(wb, "../Test_PJ//Test_PJ.xlsx", overwrite = TRUE)
