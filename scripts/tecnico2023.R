# ----------------------------------------------------------------------------
# Nome do Script: tecnicos2023.R
# Autores: Washington S. Silva
# Data de Atualizacao: 25/09/2023
# Descrição: Este script foi elaborado para gerar calendarios 
# academicos dos cursos tecnicos do IFMG - Campus Formiga
# ----------------------------------------------------------------------------
# Pacotes utilizados:
# install.packages("calendr")
# install.packages("here") # se OS -> Windows
# ----------------------------------------------------------------------------
# Entradas:
# A) Numero dos dias do ano do calendario
# B) Numero dos dias dos Eventos do calendario:
# 1. Etapa: Dia Letivo com Ministracao de Aula
# 2. Inicío de Etapa
# 3. Fim de Etapa
# 4. Dia Letivo destinado a Atividades Complementares, Extensao, 
#    Projetos Integrados ou Reposicoes
# 5. Dias Letivos destinados a reposicao de dias especificos, se for o caso.
# 6. Ferias
# 7. Feriados
# 8. Recesso escolar e Administrativo
# 9. Recupercao
# 10. Exames Finais
# 11. Jornada de Educacao, Ciencia e Tecnologia
# ----------------------------------------------------------------------------
# Saídas:
# arquivo no formato pdf contendo o calendario dos cursos tecnicos
# o arquivo sera salvo na pasta "pdf_tecnicos/"
# ----------------------------------------------------------------------------

## ativa os pacotes
library(calendR)
library(here)

## cria um vetor de dimensao igual ao numero de dias do ano
eventos <- rep(NA, 365)

## 1. Ferias
eventos[c(02:31, 32:36, 198:212, 213:218)] <- "Férias"

## 2. Etapa: Dia Letivo com Ministracao de Aula
eventos[c(
  58:62, 65:69, 72:76, 79:83, 86:90, 93:95, 100:104, 107:110, 114:118,    # Etapa 1
  123:125, 128:132, 135, 136, 138, 139,
  143:146, 149:153, 163:167, 170:174, 177:181, 184:188, 191:195, 219:223, # Etapa 2
  228:230, 233:237, 240,
  254:258, 261:265, 268:272, 275:279, 289:293, 298:300, 303:305, 310:314, # Etapa 3
  317, 318, 320, 321, 324:328, 331:335
)] <- "Etapa: Dia Letivo com Ministração de Aula"

## 3. Inicio de Etapa
eventos[c(37, 142, 254)] <- "Inicío de Etapa"

## 4. Fim da Etapa
eventos[c(132, 241, 346)] <- "Fim de Etapa"

## 5. Feriados
eventos[c(52, 97, 111, 121, 157, 159, 227, 250, 285, 306, 319, 359)] <- "Feriado"

## 6. XII JECT
eventos[c(296:297)] <- "XII Jornada de Educação, Ciência e \nTecnologia"

## 7. Recesso Escolar
eventos[c(51, 53, 96, 156, 158, 160, 226, 251, 282:284, 286, 307, 360:363)] <- "Recesso Escolar e Administrativo"

## 8. Recuperacao
eventos[c(135:139, 242:244, 247:249)] <- "Recuperação"

## 9. Exames Finais
eventos[c(347:349, 352:354)] <- "Exames Finais"

## 10. Dia Letivo destinado as Atividades Complementares, Extensão ou Projetos 
## Integrados
eventos[c(
  38:41, 44:48, 54:56, 63, 70, 77, 84, 91, 105, 119, 122, 126,
  154, 168, 175, 182, 189, 196, 224, 231, 238, 259, 266, 273, 280, 294, 301,
  315, 322, 329, 336, 338:342, 345
)] <- "Dia Letivo destinado à Atividades Complementares, Extensão,\nProjetos Integrados ou Reposições"

## 11. Dia letivo Destinado à Reposição de Aula de Sexta-Feira
eventos[c(130)] <- "Dia Letivo Destinado à Reposição de aula de Sexta-Feira"

# Ordem desejada
ordem_desejada <- c(
  "Férias", # 1: "yellow"
  "Etapa: Dia Letivo com Ministração de Aula", # 2: "bisque3"
  "Inicio de Etapa", # 3: "orchid1"
  "Fim de Etapa", # 4: "darkorchid"
  "Feriado", # 5: "darkslategray4"
  "XII Jornada de Educação, Ciência e Tecnologia", # 6: "green"
  "Recesso Escolar e Administrativo", # 7: "darkslategray2"
  "Recuperação", # 8: "darkkhaki"
  "Exames Finais", # 9: "bisque4"
  "Dia Letivo destinado à Atividades Complementares, Extensão \nou Projetos Integrados", # 10: "darkorange"
  "Dia Letivo Destinado à Reposição de aula de Sexta-Feira" # 11: "darksalmon"
)

## definie as cores dos eventos.
cores_ordenadas <-
  c(
    "yellow", # Ferias
    "bisque3", # Etapa: Dia Letivo
    "orchid1", # Inicio de Etapa
    "darkorchid", # Fim de Etapa
    "darkslategray4", # Feriado
    "green", # XII JECT
    "darkslategray2", # Recesso Escolar
    "darkkhaki", # Recuperação
    "bisque4", # Exames Finais
    "darkorange", # Dia Letivo destinado à Atividades Complementares \n ou Projetos Integrados
    "darksalmon" # Dia Letivo Destinado à Reposição de aula de Sexta-Feira
  )[order(ordem_desejada)]


# Funcao que geral o calendario
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
  subtitle = "Cursos Técnicos",
  subtitle.size = 20,
  orientation = "landscape",
  pdf = TRUE,
  doc_name = here("pdf_tecnicos/calendario_tecnicos2023")
)

## Total de Dias Letivos do Calendario

dias_letivos_tecnicos <-
  sum(eventos == "Etapa: Dia Letivo com Ministração de Aula", na.rm = TRUE) +
  sum(eventos == "Dia Letivo destinado à Atividades Complementares, Extensão,\nProjetos Integrados ou Reposições", na.rm = TRUE) +
  sum(eventos == "Inicio de Etapa", na.rm = TRUE) +
  sum(eventos == "Fim de Etapa", na.rm = TRUE) +
  sum(eventos == "XII Jornada de Educação, Ciência \ne Tecnologia", 
      na.rm = TRUE) + 
  sum(eventos == "Recuperação", na.rm = TRUE)
  sum(eventos == "Dia Letivo Destinado à Reposição de aula de Sexta-Feira", 
      na.rm = TRUE)

print(dias_letivos_tecnicos)

# ----------------------------------------------------------------------------
# Fim do Script
# ----------------------------------------------------------------------------
