USE HatunSearch
GO

INSERT INTO [Geography].Currency (Id, Symbol) VALUES('PEN', 'S/')
INSERT INTO [Geography].Currency (Id, Symbol) VALUES('USD', 'US$')
INSERT INTO [Geography].[Language] (Id) VALUES('ES')
INSERT INTO [Geography].Country (Id, PredominantCurrency, PredominantLanguage) VALUES('PE', 'PEN', 'ES')
INSERT INTO [Geography].CountrySupportedCurrency (Country, Currency) VALUES('PE', 'PEN')
INSERT INTO [Geography].CountrySupportedCurrency (Country, Currency) VALUES('PE', 'USD')
INSERT INTO [Geography].CountrySupportedLanguage (Country, Language) VALUES('PE', 'ES')
GO
INSERT INTO [Parameters].Gender (Id) VALUES('F')
INSERT INTO [Parameters].Gender (Id) VALUES('M')
INSERT INTO [Parameters].Gender (Id) VALUES('O')
GO
INSERT INTO Business.CurrencyExchange ([From], [To], Rate) VALUES('PEN', 'USD', 0.30)
INSERT INTO Business.CurrencyExchange ([From], [To], Rate) VALUES('USD', 'PEN', 3.38)
INSERT INTO Business.PropertyFeature DEFAULT VALUES
INSERT INTO Business.PropertyFeature DEFAULT VALUES
INSERT INTO Business.PropertyFeature DEFAULT VALUES
INSERT INTO Business.PropertyFeature DEFAULT VALUES
INSERT INTO Business.PropertyFeature DEFAULT VALUES
INSERT INTO Business.PropertyType DEFAULT VALUES
INSERT INTO Business.PropertyType DEFAULT VALUES
INSERT INTO Business.PublishMode (Currency, Cost) VALUES('USD', 128)
INSERT INTO Business.PublishMode (Currency, Cost) VALUES('USD', 256)
INSERT INTO Business.PublishMode (Currency, Cost) VALUES('USD', 512)
GO
INSERT INTO Localization.Country (Id, Language, DisplayName) VALUES('PE', 'ES', 'Perú')
INSERT INTO Localization.Currency (Id, Language, DisplayName) VALUES('PEN', 'ES', 'Sol peruano')
INSERT INTO Localization.Currency (Id, Language, DisplayName) VALUES('USD', 'ES', 'Dólar estadounidense')
INSERT INTO Localization.Gender (Id, Language, DisplayName) VALUES('F', 'ES', 'Femenino')
INSERT INTO Localization.Gender (Id, Language, DisplayName) VALUES('M', 'ES', 'Masculino')
INSERT INTO Localization.Gender (Id, Language, DisplayName) VALUES('O', 'ES', 'Otro')
INSERT INTO Localization.Language (Id, Language, DisplayName) VALUES('ES', 'ES', 'Español')
INSERT INTO Localization.PropertyFeature (Id, Language, DisplayName) VALUES(1, 'ES', 'Número de pisos')
INSERT INTO Localization.PropertyFeature (Id, Language, DisplayName) VALUES(2, 'ES', 'Disponibilidad de garaje')
INSERT INTO Localization.PropertyFeature (Id, Language, DisplayName) VALUES(3, 'ES', 'Disponibilidad de plaza de aparcamiento')
INSERT INTO Localization.PropertyFeature (Id, Language, DisplayName) VALUES(4, 'ES', 'Número de habitaciones')
INSERT INTO Localization.PropertyFeature (Id, Language, DisplayName) VALUES(5, 'ES', 'Disponibilidad de Wi-Fi')
INSERT INTO Localization.PropertyType (Id, Language, DisplayName) VALUES(1, 'ES', 'Casa')
INSERT INTO Localization.PropertyType (Id, Language, DisplayName) VALUES(2, 'ES', 'Departamento')
INSERT INTO Localization.PublishMode (Id, Language, DisplayName) VALUES(1, 'ES', 'Básico')
INSERT INTO Localization.PublishMode (Id, Language, DisplayName) VALUES(2, 'ES', 'Premium')
INSERT INTO Localization.PublishMode (Id, Language, DisplayName) VALUES(3, 'ES', 'Élite')
GO