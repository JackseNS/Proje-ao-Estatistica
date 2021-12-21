# Previsão Estatística  

  Sera apresentado no referido repositorio uma forma bem introdutoria,simples e didatica para mostrar como e realizada uma previsao estatística; deste modo sera utilizado metodos estatisticos matemáticos sobre o conceito de séries temporais utilizando modelos de modelo de espaço de estado de suavizacao exponencial, Holt - Winters e SARIMA. Utilizando, assim o critério de MAPE para a escolha do melhor modelo que vai representar a minha projeçao.
  
  Os dados a seguir foram obitidos dos dados da SEFA/PA, sera realizado para dados referentes a arrecadaçao do IPVA - Imposto sobre a Propriedade de Veículos Automotores durante o período de 2004 - 2021, um imposto estadual com o objetivo de arrecadação sobre os automóveis, independe de qual tipo de veículo for (motos, carros, ônibus, caminhões, etc.).
  
 # Statistical Forecast 
 
 A very introductory, simple and didactic form will be presented in that repository to show how a statistical forecast is carried out; in this way, mathematical statistical methods will be used on the concept of time series using exponential smoothing state space model models, Holt - Winters and SARIMA. Thus using the MAPE criterion to choose the best model that will represent my projection.
  
  The following data were obtained from SEFA/PA data, will be carried out for data referring to the collection of IPVA - Tax on the Ownership of Motor Vehicles during the period 2004 - 2021, a state tax with the purpose of collecting on automobiles, regardless of the type of vehicle (motorcycles, cars, buses, trucks, etc.).

# Resultados    
 A série do IPVA e uma serie que possuí uma sazonalidade durante esse mesmo período de 12 meses,com uma tedência de crescimento e não estacionáriedade durante o período de janeiro de 2004 á outubro de 2021. Como pode ser visto na Gráfico 01:
 
 Gráfico 01 - Arrecadação em milhões sobre o IPVA:
<div align="center">
  
![IPVA](https://user-images.githubusercontent.com/94062159/145993329-3d72a959-c87c-41cf-9970-aa2b6d188b61.png)

</div>

Supondo que a série seja aditiva séra realizado a decomposição da série separando em dados observados,tendência,sazonalidade e os resíduos. Como pode ser visto na Gráfico 02:

 Gráfico 02 - decomposição de séries temporais aditivas do IPVA:
<div align="center"> 
  
![SERIES_IPVA](https://user-images.githubusercontent.com/94062159/145993476-8d95b265-89c9-4879-abd3-43af9a9e65a5.png)
  
</div>

Agora para a realização da projeção será realizado uma parte fundamental que e a separação em dados de modelagem e dados para teste,ou seja, os dados originais que serviram para a comparação com os dados de teste que será usado realizar a previsão. O período para os dados de modelagem usados são de janeiro de 2004 á março de 2021, e os dados para teste utilizados são de abril de 2021 á outubro de 2021. Como pode ser visto na Gráfico 03:

Gráfico 03 - Dados de modelagem para a série IPVA:
<div align="center"> 
  
![MODELAGEM_IPVA](https://user-images.githubusercontent.com/94062159/145993396-69579747-11a6-44b3-925b-48e162e09076.png)
  
</div>

# Results 
 The IPVA series is a series that has a seasonality during this same 12-month period, with a trend of growth and non-stationarity during the period from January 2004 to October 2021. As can be seen in Graph 01:
 
 Graph 01 - Collection in millions on IPVA:
<div align="center">
  
![IPVA](https://user-images.githubusercontent.com/94062159/145993329-3d72a959-c87c-41cf-9970-aa2b6d188b61.png)

</div>

Assuming that the series is additive, the series will be decomposed, separating trend, seasonality and residuals into observed data. As can be seen in Graph 02:

 Graph 02 - decomposition of IPVA additive time series:
<div align="center">
  
![SERIES_IPVA](https://user-images.githubusercontent.com/94062159/145993476-8d95b265-89c9-4879-abd3-43af9a9e65a5.png)
  
</div>

Now, to carry out the projection, a fundamental part will be carried out, which is the separation of modeling data and data for testing, that is, the original data that were used for comparison with the test data that will be used to perform the prediction. The period for the modeling data used is from January 2004 to March 2021, and the test data used is from April 2021 to October 2021. As can be seen in Graph 03:

Graph 03 - Modeling data for the IPVA series:
<div align="center">
  
![MODELAGEM_IPVA](https://user-images.githubusercontent.com/94062159/145993396-69579747-11a6-44b3-925b-48e162e09076.png)
  
</div>

# Conclusão

Portanto, segundo a previsão realizada para 3 meses  ( outubro,novembro e dezembro), do mesmo ano  todos os parâmetros  recomendados pelos modelos deram erro muito acima do recomendavel , então utilizando o modelo de Holt - Winters foram escolhoidos novos parâmetros para aplicação ,causando um erro de  4,92% . Chegando na determinada previsão,apresentado na Tabela 01:

Tabela 01 - Arrecadação estimada para o IPVA,para o período de de outubro de 2021 - dezembro de 2021:
<div align="center"> 

![image](https://user-images.githubusercontent.com/94062159/146196943-609b9e2f-2a62-43c8-93b8-097ead07d21a.png)

 </div>
 
A referida pesquisa foi realizada antes da atualização da arrecadação do IPVA e no fim deste artigo foi atuzalizado a arrecadação para o mês de outubro e novembro com o valor real da arrecadação fornecido pela própria Secretária de Estado da Fazenda - SEFA. Como pode ser visto na Tabela 02:

Tabela 02 - Arrecadação real para o IPVA,para o período de de outubro de 2021 - novembro de 2021:
<div align="center"> 

![image](https://user-images.githubusercontent.com/94062159/146202830-ed8f1e3d-0d18-4de4-a750-62e2bd43fcfd.png)

</div>

# Conclusion

Therefore, according to the forecast made for 3 months (October, November and December), of the same year, all the parameters recommended by the models gave an error much higher than the recommended one, so using the Holt-Winters model, new parameters were chosen for application, causing a 4.92% error. Arriving at the given forecast, presented in Table 01:

Table 01 - Estimated IPVA collection for the period from October 2021 to December 2021:
<div align="center">

![image](https://user-images.githubusercontent.com/94062159/146196943-609b9e2f-2a62-43c8-93b8-097ead07d21a.png)

 </div>
 
This research was carried out before the update of the IPVA collection and at the end of this article the collection for the month of October and November was updated with the actual value of the collection provided by the Secretary of State for Finance - SEFA. As seen in Table 02:

Table 02 - Actual IPVA collection for the period from October 2021 to November 2021:
<div align="center">

![image](https://user-images.githubusercontent.com/94062159/146202830-ed8f1e3d-0d18-4de4-a750-62e2bd43fcfd.png)

</div> 
