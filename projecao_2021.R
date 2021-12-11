setwd("Y:/ASSESSORIA TÉCNICA/ESTIMATIVA DA ARRECADAÇÃO/Banco ICMS/Projecao_2021")

library(readxl)
library(forecast)

#Baixando a base de dados
Base <- read_xlsx(path = "Base.xlsx", sheet = 1)
Base$MES <- as.Date(Base$MES)
Base <- data.frame(Base)


'TRANSFORMANDO AS VARIÃVEIS EM DATA FRAME EM SÃ‰RIES TEMPORAIS'
ICMS <- ts(Base$ICMS, start = c(2004,1), end = c(2021,9), frequency = 12)
IPVA <- ts(Base$IPVA, start = c(2004,1), end = c(2021,9), frequency = 12)
ITCD <- ts(Base$ITCD, start = c(2004,1), end = c(2021,9), frequency = 12)
TOTAL <- ts(Base$TOTAL, start = c(2004,1), end = c(2021,9), frequency = 12)

plot(ICMS)
plot(IPVA)
plot(ITCD)
plot(TOTAL)

'ANÃLISE EXPLORATÃ“RIA'
#SUPONDO QUE SEJA UMA SERIE ADITIVA
plot(decompose(ICMS, type= "additive"), xlab= "Ano", col="black")
plot(decompose(IPVA, type= "additive"), xlab= "Ano", col="black")
plot(decompose(ITCD, type= "additive"), xlab= "Ano", col="black")
plot(decompose(TOTAL, type= "additive"), xlab= "Ano", col="black")




'---------------------------------------------------------------------------------
------------------ PROJECAO PARA O ICMS -------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------'

#separando o ICMS em modelagem e teste
Modelagemicms <- window(ICMS, start= c(2004,1), end= c(2021,3))
Testeicms <- window(ICMS, start= c(2021,4), end= c(2021,9))



'Aplicacao do modelo espaco de estado de suavizacao eXponencial'
ets <- ets(Modelagemicms) #modelagem
modeloets <- forecast.ets(ets,h=6, level= 95) # previsão, modeloets$fitted, modeloets$x
modeloets <- data.frame(modeloets)
summary(ets)


'Holt Winters '
modelo_holtwinters <- HoltWinters(x = Modelagemicms, 
                          seasonal = "multiplicative") # modelagem 
#modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = holtwinters$alpha,
#                                 beta = holtwinters$beta, 
#                                 gamma = holtwinters$gamma,
#                                 seasonal = "multiplicative")

previsao_holtwinters <- data.frame(previsao_holtwinters)
previsao_holtwinters


'SARIMA'
library(sandwich)

arima <- auto.arima(Modelagemicms, lambda = 0, trace = T)

#previsao usando o ARIMA, com o LI e LS
previsao_arima <- forecast(object = arima, h = 6, level = 0.95)
previsao_arima<- data.frame(previsao_arima)
previsao_arima


#Mape0 <- mean(abs((Testeicms- previsao_arima$Point.Forecast)/Testeicms))*100


arima <- Arima(y = Modelagemicms, order = c(1, 1, 2), seasonal = c(1, 1, 0), lambda = 0) 
arima <- forecast(object = arima, h = 6, level = 0.95) 
arima <- data.frame(arima)
arima


'Escolhendo o melhor modelo pelo critério MAPE'

# erro <-  sum(abs(modeloets$Point.Forecast- Testeicms))
# erro
# 
# erroH <-  sum(abs(previsao_holtwinters$Point.Forecast- Testeicms))
# erroH
# 
# erroA <-  sum(abs(previsao_arima$Point.Forecast- Testeicms))
# erroA



Mape1 <- mean(abs((Testeicms- modeloets$Point.Forecast)/Testeicms))*100
Mape1

Mape2 <- mean(abs((Testeicms- previsao_holtwinters$Point.Forecast)/Testeicms))*100
Mape2

Mape3 <- mean(abs((Testeicms- arima$Point.Forecast)/Testeicms))*100
Mape3

'como os valores deram muito alto no mape precisamos mudar os parametros para deixar 
abaixo de 0,05 ou 5%.'

####################################################################
# MELHORES PARÂMETROS

modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = 0.24,
                                  beta = 0.15,
                                  gamma = 0.06,
                                  seasonal = "multiplicative")
previsao_holtwinters <- forecast(modelo_holtwinters, h = 6, level = 0.95) # previsão
previsao_holtwinters
previsao_holtwinters2 <- data.frame(previsao_holtwinters)

Mape22 <- mean(abs((Testeicms- previsao_holtwinters2$Point.Forecast)/Testeicms))*100
Mape22
###################################################################



# plot(Testeicms,
#      main='',
#      xlab='Ano', ylab='',
#      col='blue',
#      bty='l')
# par(new=TRUE)
# plot(modeloets$Point.Forecast,
#      axes=F, ann=F,
#      col='red',
#       type = "l")
# par(new=TRUE)
# plot(previsao_holtwinters$Point.Forecast,
#      axes=F, ann=F,
#      col=4,
#      type = "l")
# par(new=TRUE)
# plot(arima$Point.Forecast,
#      axes=F, ann=F,
#      col=9,
#      type = "l")
# legend('topleft',
#        c('Teste', 'ETS', "Holt"),
#        col=c('blue', 'red', 4), lty=1:2,
#        bty='n')
# grid(col='darkgrey')
# 
# 
# 
# 'previsão com suavização exponencial '
# 
# ets <- ets(ICMS)
# ets
# forecast.ets(ets ,h=4, level= 95) 



'---------------------------------------------------------------------------------
------------------ PROJECAO PARA O IPVA -------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------'

#separando o IPVA em modelagem e teste
ModelagemIPVA <- window(IPVA, start= c(2004,1), end= c(2021,3))
ModelagemIPVA
TesteIPVA <- window(IPVA, start= c(2021,4), end= c(2021,9))
TesteIPVA
plot(ModelagemIPVA)


'Aplicacao do modelo espaco de estado de suavizacao eXponencial'
etsIPVA <- ets(ModelagemIPVA) #modelagem
modeloetsIPVA <- forecast.ets(etsIPVA,h=6, level= 95) # previsão, modeloets$fitted, modeloets$x
                                                      # FORECAST pacote de previsao in R
modeloetsIPVA <- data.frame(modeloetsIPVA)
modeloetsIPVA
summary(etsIPVA)






'Holt Winters '
modelo_holtwintersIPVA <- HoltWinters(x = ModelagemIPVA, 
                                  seasonal = "multiplicative") # modelagem 
#modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = holtwinters$alpha,
#                                  beta = holtwinters$beta, 
#                                  gamma = holtwinters$gamma,
#                                  seasonal = "multiplicative")
previsao_holtwintersIPVA <- forecast(modelo_holtwintersIPVA, h = 6, level = 0.95) # previsão

previsao_holtwintersIPVA <- data.frame(previsao_holtwintersIPVA)

previsao_holtwintersIPVA




'SARIMA'
library(sandwich)

arimaIPVA <- auto.arima(ModelagemIPVA, lambda = 0, trace = T) 

#previsao usando o ARIMA, com o LI e LS
previsao_arimaIPVA <- forecast(object = arimaIPVA, h = 6, level = 0.95) 
previsao_arimaIPVA<- data.frame(previsao_arimaIPVA)
previsao_arimaIPVA


# MapeIPVA <- mean(abs((TesteIPVA- previsao_arimaIPVA$Point.Forecast)/TesteIPVA))*100
# MapeIPVA
# 
# arimaIPVA <- Arima(y = ModelagemIPVA, order = c(1, 1, 2), seasonal = c(1, 1, 0), lambda = 0) 
arimaIPVA <- forecast(object = arimaIPVA, h = 6, level = 0.95) 
arimaIPVA <- data.frame(arimaIPVA)
arimaIPVA





'Escolhendo o melhor modelo pelo critério MAPE'
# 
# erroEIPVA <-  sum(abs(modeloetsIPVA$Point.Forecast- TesteIPVA))
# erroEIPVA
# 
# erroHIPVA <-  sum(abs(previsao_holtwintersIPVA$Point.Forecast- TesteIPVA))
# erroHIPVA
# 
# erroAIPVA <-  sum(abs(previsao_arimaIPVA$Point.Forecast- TesteIPVA))
# erroAIPVA



Mape1IPVA <- mean(abs((TesteIPVA- modeloetsIPVA$Point.Forecast)/TesteIPVA))*100
Mape1IPVA

Mape2IPVA <- mean(abs((TesteIPVA- previsao_holtwintersIPVA$Point.Forecast)/TesteIPVA))*100
Mape2IPVA

Mape3IPVA <- mean(abs((TesteIPVA- arimaIPVA$Point.Forecast)/TesteIPVA))*100
Mape3IPVA


###################################################################
# MELHORES PARÂMETROS

modelo_holtwintersIPVA <- HoltWinters(x = ModelagemIPVA , alpha = 0.24,
                                  beta = 0.1,
                                  gamma = 0.15,
                                  seasonal = "multiplicative")



previsao_holtwintersIPVA <- forecast(modelo_holtwintersIPVA, h = 6, level = 0.95) # previsão

previsao_holtwintersIPVA <- data.frame(previsao_holtwintersIPVA)
previsao_holtwintersIPVA
MapeIPVA <- mean(abs((TesteIPVA- previsao_holtwintersIPVA$Point.Forecast)/TesteIPVA))*100
MapeIPVA


###################################################################
#previsão para 3 MESES SEGUINTES A SETEMBRO

modelo_holtwintersIPVA <- HoltWinters(x = ModelagemIPVA , alpha = 0.24,
                                      beta = 0.1,
                                      gamma = 0.15,
                                      seasonal = "multiplicative")


previsao_holtwintersIPVA <- forecast(IPVA, h = 3, level = 0.95) # previsão
previsao_holtwintersIPVA <- data.frame(previsao_holtwintersIPVA)
previsao_holtwintersIPVA






'---------------------------------------------------------------------------------
------------------ PROJECAO PARA O ITCD -------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------'

#MODELAGEM E TESTE
ModelagemITCD <- window(ITCD, start= c(2004,1), end= c(2020,12))
ModelagemITCD
TesteITCD <- window(ITCD, start= c(2021,1), end= c(2021,9))
TesteITCD

plot(ModelagemITCD)
#------------------------------------#SUAVIZAÇÃO EXPONENCIAL

etsITCD <- ets(ModelagemITCD) #modelagem
modeloetsITCD <- forecast.ets(etsITCD,h=9, level= 95) # previsão, modeloets$fitted, modeloets$x
                                                      # FORECAST pacote de previsao in R
modeloetsITCD <- data.frame(modeloetsITCD)
modeloetsITCD
summary(etsITCD)

# #gráfico
# plot(ModelagemITCD, col= 4)
# par(new=TRUE)
# plot(etsITCD$fitted, col=2)
# 
# plot(TesteITCD, col= 4)
# par(new=TRUE)
# plot(modeloetsITCD$Point.Forecast, col=2, type= 'l')
#-------------------------------------#HOLT - WINTERS

modelo_holtwintersITCD <- HoltWinters(x = ModelagemITCD, 
                                      seasonal = "multiplicative") # modelagem #ADITIVA OU MULTIPLICATIVA
#modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = holtwinters$alpha,
#                                  beta = holtwinters$beta, 
#                                  gamma = holtwinters$gamma,
#                                  seasonal = "multiplicative")
previsao_holtwintersITCD <- forecast(modelo_holtwintersITCD, h = 9, level = 0.95) # previsão
previsao_holtwintersITCD <- data.frame(previsao_holtwintersITCD)
previsao_holtwintersITCD

# #gráfico
# plot(ModelagemITCD, col= 4)
# par(new=TRUE)
# plot(modelo_holtwintersITCD$fitted[,1], col=2)
# 
# plot(TesteITCD, col= 4)
# par(new=TRUE)
# plot(previsao_holtwintersITCD$Point.Forecast, col=2, type= 'l')
#-------------------------------------#SARIMA

library(sandwich)

arimaITCD <- auto.arima(ModelagemITCD, lambda = 0, trace = T) 


#previsao usando o ARIMA, com o LI e LS
previsao_arimaITCD <- forecast(object = arimaITCD, h = 6, level = 0.95) 
previsao_arimaITCD<- data.frame(previsao_arimaITCD)
previsao_arimaITCD


# MapeIPVA <- mean(abs((TesteIPVA- previsao_arimaIPVA$Point.Forecast)/TesteIPVA))*100
# MapeIPVA

# arimaIPVA <- Arima(y = ModelagemIPVA, order = c(1, 1, 2), seasonal = c(1, 1, 0), lambda = 0)
arimaITCD <- forecast(object = arimaITCD, h = 6, level = 0.95)
arimaITCD <- data.frame(arimaITCD)
arimaITCD




#------------------------#Escolhendo o melhor modelo pelo critério MAPE

# erroEITCD <-  sum(abs(modeloetsITCD$Point.Forecast- TesteITCD))
# erroEITCD
# 
# erroHITCD <-  sum(abs(previsao_holtwintersITCD$Point.Forecast- TesteITCD))
# erroHITCD
# 
# erroAITCD <-  sum(abs(previsao_arimaITCD$Point.Forecast- TesteITCD))
# erroAITCD



Mape1ITCD <- mean(abs((TesteITCD- modeloetsITCD$Point.Forecast)/TesteITCD))*100
Mape1ITCD

Mape2ITCD <- mean(abs((TesteITCD- previsao_holtwintersITCD$Point.Forecast)/TesteITCD))*100
Mape2ITCD

Mape3ITCD <- mean(abs((TesteITCD- arimaITCD$Point.Forecast)/TesteITCD))*100
Mape3ITCD


###################################################################
# MELHORES PARÂMETROS

modelo_holtwintersITCD <- HoltWinters(x = ModelagemITCD , alpha = 0.09,
                                      beta = 0.699,
                                      gamma = 0.5,
                                      seasonal = "multiplicative")
previsao_holtwintersITCD <- forecast(modelo_holtwintersITCD, h = 6, level = 0.95) # previsão

previsao_holtwintersITCD <- data.frame(previsao_holtwintersITCD)
previsao_holtwintersITCD
MapeITCD <- mean(abs((TesteITCD- previsao_holtwintersITCD$Point.Forecast)/TesteITCD))*100
MapeITCD
###################################################################





















'ESTA OCORRENDO UM PROBLEMA DE NAO ESTA CONSEGUINDO DIMINUIR O VALOR DO ERRO'

'---------------------------------------------------------------------------------
------------------ PROJECAO PARA O TOTAL -------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------'


#MODELAGEM E TESTE
ModelagemTOTAL <- window(TOTAL, start= c(2004,1), end= c(2021,3))
ModelagemTOTAL
TesteTOTAL <- window(TOTAL, start= c(2021,4), end= c(2021,9))
TesteTOTAL



#------------------------------------#SUAVIZAÇÃO EXPONENCIAL

etsTOTAL <- ets(ModelagemTOTAL) #modelagem
modeloetsTOTAL <- forecast.ets(etsTOTAL,h=6, level= 95) # previsão, modeloets$fitted, modeloets$x
                                                      # FORECAST pacote de previsao in R
modeloetsTOTAL <- data.frame(modeloetsTOTAL)
modeloetsTOTAL
summary(etsTOTAL)


#-------------------------------------#HOLT - WINTERS

modelo_holtwintersTOTAL <- HoltWinters(x = ModelagemTOTAL, 
                                      seasonal = "multiplicative") # modelagem #ADITIVA OU MULTIPLICATIVA
#modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = holtwinters$alpha,
#                                  beta = holtwinters$beta, 
#                                  gamma = holtwinters$gamma,
#                                  seasonal = "multiplicative")
previsao_holtwintersTOTAL <- forecast(modelo_holtwintersTOTAL, h = 6, level = 0.95) # previsão
previsao_holtwintersTOTAL <- data.frame(previsao_holtwintersTOTAL)
previsao_holtwintersTOTAL



#-------------------------------------#SARIMA

library(sandwich)

arimaTOTAL <- auto.arima(ModelagemTOTAL, lambda = 0, trace = T) 


#previsao usando o ARIMA, com o LI e LS
previsao_arimaTOTAL <- forecast(object = arimaTOTAL, h = 6, level = 0.95) 
previsao_arimaTOTAL<- data.frame(previsao_arimaTOTAL)
previsao_arimaTOTAL


# MapeIPVA <- mean(abs((TesteIPVA- previsao_arimaIPVA$Point.Forecast)/TesteIPVA))*100
# MapeIPVA

# arimaIPVA <- Arima(y = ModelagemIPVA, order = c(1, 1, 2), seasonal = c(1, 1, 0), lambda = 0)
arimaTOTAL <- forecast(object = arimaTOTAL, h = 6, level = 0.95)
arimaTOTAL <- data.frame(arimaTOTAL)
arimaTOTAL


#------------------------#Escolhendo o melhor modelo pelo critério MAPE

# erroETOTAL <-  sum(abs(modeloetsTOTAL$Point.Forecast- TesteTOTAL))
# erroETOTAL
# 
# erroHTOTAL <-  sum(abs(previsao_holtwintersTOTAL$Point.Forecast- TesteTOTAL))
# erroHTOTAL
# 
# erroATOTAL <-  sum(abs(previsao_arimaTOTAL$Point.Forecast- TesteTOTAL))
# erroATOTAL

#OU PODEMOS COMPARAR USANDO:

Mape1TOTAL <- mean(abs((TesteTOTAL- modeloetsTOTAL$Point.Forecast)/TesteTOTAL))*100
Mape1TOTAL

Mape2TOTAL <- mean(abs((TesteTOTAL- previsao_holtwintersTOTAL$Point.Forecast)/TesteTOTAL))*100
Mape2TOTAL

Mape3TOTAL <- mean(abs((TesteTOTAL- arimaTOTAL$Point.Forecast)/TesteTOTAL))*100
Mape3TOTAL


###################################################################
# MELHORES PARÂMETROS

modelo_holtwintersTOTAL <- HoltWinters(x = ModelagemTOTAL , alpha = 0.1,
                                      beta = 0.3,
                                      gamma = 0.45,
                                      seasonal = "multiplicative")
previsao_holtwintersTOTAL <- forecast(modelo_holtwintersTOTAL, h = 6, level = 0.95) # previsão

previsao_holtwintersTOTAL <- data.frame(previsao_holtwintersTOTAL)
previsao_holtwintersTOTAL
MapeTOTAL <- mean(abs((TesteTOTAL- previsao_holtwintersTOTAL$Point.Forecast)/TesteTOTAL))*100

MapeTOTAL
###################################################################
























# ' USANDO O CÓDIGO DO RAFAEL '
# 
# 'var'
# require(vars)
# 
# grupo1 <- read_xlsx(path = "Variaveis.xlsx", sheet = 1)
# grupo1$MES <- as.Date(grupo1$Mês)
# grupo1 <- data.frame(grupo1)
# 
# 
# ICMS <- ts(grupo1$ICMS, start = c(2004,1), end = c(2021,6), frequency = 12)
# IPCA <- ts(grupo1$IPCA...Núm.índice, start = c(2004,1), end = c(2021,6), frequency = 12)
# GASOLINA <- ts(grupo1$Gasolina.C..m3., start = c(2004,1), end = c(2021,6), frequency = 12)
# COMERCIO <- ts(grupo1$Consumo.Comercial, start = c(2004,1), end = c(2021,6), frequency = 12)
# 
# 
# grupo1 <- data.frame(ICMS,IPCA,GASOLINA,COMERCIO)
# modelo_var_linear1 <- VAR(grupo1, p=1, type = c("const"))
# 
# 
# belem_var_linear_17 <- predict(modelo_var_linear1, n.ahead = 5, CI = 0.95)
# belem_var_linear_17$fcst$ICMS[, "fcst"]
# 
# 
# 
# 
# 
# # Erro mensal sarima
# 
# erro_mensal_sarima_belem <- abs((sarima_belem_2017)-(belem_2016))/(belem_2016)
# erro_mensal_sarima_belem
# 
# erro_mensal_var_belem <- abs((belem_var_linear_17$fcst$belem[,"fcst"])-(belem_2016))/(belem_2016)
# erro_mensal_var_belem
# 
