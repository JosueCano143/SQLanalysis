--Crear y Usar BD
CREATE DATABASE Curso_Abril;
USE [CursoSQL_COVID];

--Una vez importada la tabla, conocer los datos mediante SELECT:
SELECT  * 
FROM [dbo].[covid19table];

--Ordenar por la columan SNo:
SELECT  * 
FROM [dbo].[covid19table]
ORDER BY [SNo] ASC;

--Contar # de entradas
SELECT  COUNT([SNo])
FROM [dbo].[covid19table];

--Total casos confirmados
SELECT  MAX([Confirmed])
FROM [dbo].[covid19table];

--Paises únicos
SELECT  DISTINCT  [Country_Region]
FROM [dbo].[covid19table];

###--------------------------####
--Usando condicional where para selecionar por pais
SELECT * FROM [dbo].[covid19table]
WHERE [Country_Region] = 'Mainland China';

--Usando condicional WHERE y AND 
SELECT * FROM [dbo].[covid19table]
WHERE [Country_Region] = 'Mainland China' AND [Province_State] = 'Beijing';

--Usando WHERE, AND Y HAVING
SELECT * FROM [dbo].[covid19table]
WHERE [Country_Region] = 'Mainland China' AND [Province_State] = 'Beijing'
HAVING [days] <= 20 ;

##--------------------------###


--Número de entradas por país
SELECT  DISTINCT  [Country_Region]
	, COUNT([SNo]) Total
FROM [dbo].[covid19table]
GROUP BY [Country_Region]
ORDER BY Total DESC;

--Número de entradas por país/estado
SELECT  DISTINCT  [Country_Region],[Province_State], COUNT([SNo]) Total
FROM [dbo].[covid19table]
GROUP BY [Country_Region],[Province_State]
ORDER BY Total DESC;

--Número de casos or país/estado
SELECT  DISTINCT  [Country_Region]
	,[Province_State]
	,MAX([Confirmed])'Casos confirmados'
FROM [dbo].[covid19table]
GROUP BY [Country_Region],[Province_State]
ORDER BY 'Casos confirmados' DESC;

--Número de casos, muertes y curados país/estado, con Año,Mes,Día
SELECT DISTINCT DAY([ObservationDate]) 'Dia'
	,MONTH([ObservationDate]) 'Mes'
	,YEAR([ObservationDate]) 'Año'
	,[Country_Region]
	,[Province_State]
	,SUM([Confirmed])'Casos Confirmed'
	,SUM([Deaths])'Casos Deaths'
	,SUM([Recovered])'Casos Recovered'
FROM [dbo].[covid19table]
GROUP BY [Country_Region]
	,[Province_State]
	,YEAR([ObservationDate])
	,MONTH([ObservationDate])
	,DAY([ObservationDate])
ORDER BY 'Casos Confirmed' DESC;

--Casos activos (Confirmados-(Muertes-Curados))
SELECT DISTINCT DAY([ObservationDate]) 'Dia'
	,MONTH([ObservationDate]) 'Mes'
	,YEAR([ObservationDate]) 'Año'
	,[Country_Region]
	,[Province_State]
	,SUM([Confirmed])'Casos Confirmed'
	,SUM([Deaths])'Casos Deaths'
	,SUM([Recovered])'Casos Recovered'
	,(SUM([Confirmed])-(SUM([Deaths])-SUM([Recovered])))'Activos'
FROM [dbo].[covid19table]
GROUP BY [Country_Region]
	,[Province_State]
	,YEAR([ObservationDate])
	,MONTH([ObservationDate])
	,DAY([ObservationDate])
ORDER BY 'Casos Confirmed' DESC;

--Guardar Tabla
SELECT DISTINCT DAY([ObservationDate]) 'Dia'
	,MONTH([ObservationDate]) 'Mes'
	,YEAR([ObservationDate]) 'Año'
	,[Country_Region]
	,[Province_State]
	,SUM([Confirmed])'Casos Confirmed'
	,SUM([Deaths])'Casos Deaths'
	,SUM([Recovered])'Casos Recovered'
	,(SUM([Confirmed])-(SUM([Deaths])-SUM([Recovered])))'Activos'
INTO COVID_2020
FROM [dbo].[covid19table]
GROUP BY [Country_Region]
	,[Province_State]
	,YEAR([ObservationDate])
	,MONTH([ObservationDate])
	,DAY([ObservationDate])
ORDER BY 'Casos Confirmed' DESC;

--Tabla Nueva
SELECT *
FROM [dbo].[covid19table];

--Eliminar Columna
ALTER TABLE [dbo].[COVID_2020] DROP [Casos Recovered];

--Eliminar Tabla
DROP TABLE [dbo].[COVID_2020];


------------------
SELECT *
FROM [dbo].[estado_cord];

SELECT *
FROM [dbo].[estado_cord]
WHERE [estado] LIKE 'JALISCO%';

SELECT DISTINCT [Column_1], [estado]
FROM [dbo].[estado_cord];

SELECT T1.[Column_1]
		,T1.[N_Caso]
		,T1.[Estado]
		,T1.[Sexo]
		,T1.[Edad]
		,T1.[Inicio_de]
		,T1.[por_RT_PCR]
		,T1.[Procedencia]
		,T1.[llegada_a]
INTO COVID_CodigoEstadoM
FROM  [dbo].[reporte_Mexico] AS T1
LEFT JOIN [dbo].[estado_cord] AS T2
ON T1.[Estado] = T2.[estado]
WHERE T1.[Estado] = T2.[estado];

SELECT *
FROM [dbo].[reporte_Mexico];

SELECT *
FROM [dbo].[estado_cord]
ORDER BY [Estado] ASC;
​