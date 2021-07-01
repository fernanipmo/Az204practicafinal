# Practica Final de Az-204 junio 2021



OpenStreetMap WKT Playground

[Draw features example (clydedacruz.github.io)](https://clydedacruz.github.io/openstreetmap-wkt-playground/)



### SQLPackage

Instalado con el MSSQL Server Management Studio

En la ruta: 

```
C:\Program Files\Microsoft SQL Server\150\DAC\bin\SqlPackage.exe
```

Desde powershell

```
C:\"Program Files"\"Microsoft SQL Server"\150\DAC\bin\sqlpackage.exe /action:Extract /TargetFile:"bus-db.dacpac"  /SourceConnectionString:"Server=tcp:bus-serverjun2021bmvb.database.windows.net,1433;Initial Catalog=bus-db;Persist Security Info=False;User ID=cloudadmin;Password={password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
```

Connection String

```
Server=tcp:bus-serverjun2021bmvb.database.windows.net,1433;Initial Catalog=bus-db;Persist Security Info=False;User ID=cloudadmin;Password={password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```



[Unidad 7 de 8](https://docs.microsoft.com/es-es/learn/modules/create-foundation-modern-apps/7-exercise-automate-updates)

```
Ejercicio: Automatización de actualizaciones con Acciones de GitHub
```

