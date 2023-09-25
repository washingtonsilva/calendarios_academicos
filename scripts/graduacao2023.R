# ----------------------------------------------------------------------------
# Nome do Script: graduacao2023.R
# Autores: Washington S. Silva
# Data de Atualizacao: 25/09/2023
# Descrição: Este script foi elaborado para gerar calendarios 
# academicos dos cursos de graducado do IFMG - Campus Formiga
# ----------------------------------------------------------------------------
# Pacotes utilizados:
# install.packages("calendr")
# install.packages("here") # se OS Windows
# ----------------------------------------------------------------------------
# Entradas:
# A) Numero dos dias do ano do calendario
# B) Numero dos dias dos Eventos do calendario:
# 1. Dia Letivo com Ministração de Aula
# 2. Dia Letivo destinado a Atividades Complementares, Extensao, 
#    Projetos Integrados ou Reposicoes
# 3. Dias Letivos destinados a reposicao de dias especificos, se for o caso.
# 4. ferias
# 5. feriados
# 6. recesso escolar e administrativo
# 7. inicio de periodo letivo (do primeiro e segundo semestre)
# 8. fim do periodo letivo (do primeiro e segundo semestre)
# 9. exames finais (do primeiro e segundo semestres)
# 10. Jornada de Educacao, Ciencia e Tecnologia
# ----------------------------------------------------------------------------
# Saídas:
# arquivo no formato pdf contendo o calendario dos cursos de graduacao
# o arquivo sera salvo na pasta "pdf_graduacao/"
# ----------------------------------------------------------------------------

## ativa os pacotes
library(calendR)
library(here)

## cria um vetor de dimensao igual ao numero de dias do ano
eventos <- rep(NA, 365)

## 1. ferias
eventos[c(02:31, 32:36, 198:212, 213:218)] <- "Férias"

## 2. dias letivos
eventos[c(
  65:69, 72:76, 79:83, 86:90, 93:95, 100:104, 107:110, 114:118, 123:125,
  128:132, 135:139, 142:146, 149:153, 163:167, 170:174, 177:181, 219:223,
  228:230, 233:237, 240:244, 247:249, 254:258, 261:265, 268:272, 275:279,
  289:293, 298:300, 303:305, 310:314, 317, 318, 320, 321, 324:328, 331:335,
  338, 339, 341, 342
)] <- "Dia Letivo com Ministração de Aula"

## 3. inicio de periodo letivo (do primeiro e segundo semestre)
eventos[c(37, 219)] <- "Inicio do Periodo Letivo"

## 4. fim do periodo letivo (do primeiro e segundo semestre)
eventos[c(188, 349)] <- "Fim do Periodo Letivo"

## 5. XII JECT
eventos[c(296:297)] <- "XII Jornada de Educação, Ciência \ne Tecnologia"

## 6. feriados
eventos[c(
  52, 97, 111, 121, 157, 159,
  227, 250, 285, 306, 319, 359
)] <- "Feriado"

## 7. recesso escolar e administrativo
eventos[c(
  51, 53, 96, 156, 158, 160, 226,
  251, 282:284, 286, 307, 360:363
)] <- "Recesso Escolar e Administrativo"

## 8. dia letivo destinado as atividades complementares, extensao ou
## projetos integrados
eventos[c(
  38:41, 44:48, 54, 55, 58:62, 77, 84, 105, 119, 122,
  133, 140, 154, 168, 175, 184:187, 231, 238, 245,
  259, 266, 273, 280, 294, 315, 329, 340, 345:348
)] <- "Dia Letivo destinado à Atividades Complementares,\nExtensão, 
Projetos Integrados ou Reposições"


## 9. dia letivo destinado a reposicao de aula de sexta-feira
eventos[c(130)] <- "Dia Letivo Destinado à Reposição de aula de\nSexta-Feira"

## 10. exames finais (do primeiro e segundo semestres)
eventos[c(191:194, 352:355)] <- "Exames Finais"

## exibe a ordem dos eventos neste instante
## levels(factor(eventos))

## 11. define os eventos do calendario
ordem_desejada <- c(
  "Férias", # 1: "yellow"
  "Dia Letivo com Ministração de Aula", # 2: "bisque3"
  "Inicio do Periodo Letivo", # 3: "orchid1"
  "Fim do Periodo Letivo", # 4: "darkorchid"
  "XII Jornada de Educação, Ciência e \n Tecnologia", # 5: "green"
  "Feriado", # 6: "darkslategray4"
  "Recesso Escolar", # 7: "darkslategray2"
  "Exames Finais", # 8: "bisque4"
  "Dia Letivo Destinado à Reposição de Aula de Sexta-Feira", # 9: "darksalmon"
  "Dia Letivo destinado à Atividades Complementares,\nExtensão ou 
  Projetos Integrados" # 10: "darkorange"
)

## definie as cores dos eventos.
cores_ordenadas <-
  c(
    "yellow", # Ferias
    "bisque3", # Dia Letivo com Ministração de Aula
    "orchid1", # Inicio do Periodo Letivo
    "darkorchid", # Fim do Periodo Letivo
    "green", # XI JECT
    "darkslategray4", # Feriado
    "darkslategray2", # Recesso Escolar
    "bisque4", # Exames Finais
    "darksalmon", # Dia letivo Destinado à Reposição de Aula de Sexta-Feira
    "darkorange" # Dia Letivo destinado à Atividades Complementares ou Projetos Integrados
  )[order(ordem_desejada)]


# Funcao que gera o calendario
calendR(
  start_date = "2023-01-01",
  end_date = "2023-12-31",
  start = "S",
  mbg.col = "gray97",
  special.days = eventos,
  special.col = cores_ordenadas,
  legend.pos = "bottom",
  bg.col = "#FFFFFF",
  title = "Calendário Acadêmico 2023", # Altera título do calendario
  title.size = 25,
  subtitle = "Cursos de Graduação",
  subtitle.size = 20,
  orientation = "landscape",
  pdf = TRUE,
  doc_name = here("pdf_graduacao/calendario_graduacao2023")
)

# ----------------------------------------------------------------------------
# Fim do Script
# ----------------------------------------------------------------------------