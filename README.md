# Previsão Estatística

  Sera apresentado no referido repositorio uma forma bem introdutoria,simples e didatica para mostrar como e realizada uma previsao estatística; deste modo sera utilizado metodos estatisticos matemáticos sobre o conceito de séries temporais utilizando modelos de modelo de espaço de estado de suavizacao exponencial, Holt - Winters e SARIMA. Utilizando, assim o critério de MAPE para a escolha do melhor modelo que vai representar a minha projeçao.
  
  Os dados a seguir foram obitidos dos dados da SEFA/PA, sera realizado para dados referentes a arrecadaçao do IPVA - Imposto sobre a Propriedade de Veículos Automotores durante o período de 2004 - 2021, um imposto estadual com o objetivo de arrecadação sobre os automóveis, independe de qual tipo de veículo for (motos, carros, ônibus, caminhões, etc.).
  
 # Statistical Forecast
 
 A very introductory, simple and didactic form will be presented in that repository to show how a statistical forecast is carried out; in this way, mathematical statistical methods will be used on the concept of time series using exponential smoothing state space model models, Holt - Winters and SARIMA. Thus using the MAPE criterion to choose the best model that will represent my projection.
  
  The following data were obtained from SEFA/PA data, will be carried out for data referring to the collection of IPVA - Tax on the Ownership of Motor Vehicles during the period 2004 - 2021, a state tax with the purpose of collecting on automobiles, regardless of the type of vehicle (motorcycles, cars, buses, trucks, etc.).

# Conclusão 
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
