setwd("Y:/ASSESSORIA TÉCNICA/ESTIMATIVA DA ARRECADAÇÃO/Banco ICMS/Projecao_2021")

library(readxl)
library(forecast)

#Baixando a base de dados
Base <- read_xlsx(path = "Base.xlsx", sheet = 1)
Base$MES <- as.Date(Base$MES)
Base <- data.frame(Base)


#TRANSFORMANDO AS VARIAVEIS EM DATA FRAME EM SERIES TEMPORAIS
IPVA <- ts(Base$IPVA, start = c(2004,1), end = c(2021,9), frequency = 12)

plot(IPVA)

#ANALISE EXPLORATORIA

#SUPONDO QUE SEJA UMA SERIE ADITIVA

plot(decompose(IPVA, type= "additive"), xlab= "Ano", col="black")


#---------------------------------------------------------------------------------
#------------------ PROJECAO PARA O IPVA -------------------------------------------
#----------------------------------------------------------------------------------
#----------------------------------------------------------------------------------

#separando o IPVA em modelagem e teste
ModelagemIPVA <- window(IPVA, start= c(2004,1), end= c(2021,3))
ModelagemIPVA
TesteIPVA <- window(IPVA, start= c(2021,4), end= c(2021,9))
TesteIPVA
plot(ModelagemIPVA)


#-------------------------------------------------------Aplicacao do modelo espaco de estado de suavizacao eXponencial----------------------------------------------------------#
etsIPVA <- ets(ModelagemIPVA) #modelagem
modeloetsIPVA <- forecast.ets(etsIPVA,h=6, level= 95) # previsão, modeloets$fitted, modeloets$x
                                                      # FORECAST pacote de previsao in R
modeloetsIPVA <- data.frame(modeloetsIPVA)
modeloetsIPVA
summary(etsIPVA)

#----------------------------------------------------------------------------------Holt Winters---------------------------------------------------------------------------------#
modelo_holtwintersIPVA <- HoltWinters(x = ModelagemIPVA, 
                                  seasonal = "multiplicative") # modelagem 
#modelo_holtwinters <- HoltWinters(x = Modelagemicms , alpha = holtwinters$alpha,
#                                  beta = holtwinters$beta, 
#                                  gamma = holtwinters$gamma,
#                                  seasonal = "multiplicative")
previsao_holtwintersIPVA <- forecast(modelo_holtwintersIPVA, h = 6, level = 0.95) # previsão

previsao_holtwintersIPVA <- data.frame(previsao_holtwintersIPVA)

previsao_holtwintersIPVA

#----------------------------------------------------------------------------------SARIMA---------------------------------------------------------------------------------------#
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

#--------------------------------------------------------------------Escolhendo o melhor modelo pelo critério MAPE--------------------------------------------------------------#

Mape1IPVA <- mean(abs((TesteIPVA- modeloetsIPVA$Point.Forecast)/TesteIPVA))*100
Mape1IPVA

Mape2IPVA <- mean(abs((TesteIPVA- previsao_holtwintersIPVA$Point.Forecast)/TesteIPVA))*100
Mape2IPVA

Mape3IPVA <- mean(abs((TesteIPVA- arimaIPVA$Point.Forecast)/TesteIPVA))*100
Mape3IPVA


###################################################################
# MELHORES PARÂMETROS
########################################################################
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
