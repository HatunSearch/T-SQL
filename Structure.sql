CREATE DATABASE HatunSearch
GO

USE HatunSearch
GO

CREATE SCHEMA Business
GO
CREATE SCHEMA [Geography]
GO
CREATE SCHEMA Localization
GO
CREATE SCHEMA [Parameters]
GO
CREATE SCHEMA Payments
GO
CREATE SCHEMA [Security]
GO

CREATE LOGIN HatunSearch WITH PASSWORD = '$13fdb311d027b3e9$'
GO

CREATE USER HatunSearch FOR LOGIN HatunSearch
GO

GRANT DELETE TO HatunSearch
GRANT INSERT TO HatunSearch
GRANT SELECT TO HatunSearch
GRANT UPDATE TO HatunSearch
GO

CREATE TABLE Business.CurrencyExchange
(
	[From] CHAR(3) NOT NULL,
	[To] CHAR(3) NOT NULL,
	Rate DECIMAL(18, 4) NOT NULL,
	UpdatedAt DATETIME NOT NULL CONSTRAINT DF_Business_CurrencyExchange_UpdatedAt DEFAULT GETUTCDATE(),
	CONSTRAINT PK_Business_CurrencyExchange PRIMARY KEY ([From], [To])
)
CREATE TABLE Business.Customer
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Business_Customer_Id DEFAULT NEWID(),
	Username NVARCHAR(32) NOT NULL,
	[Password] BINARY(64) NOT NULL,
	FirstName NVARCHAR(16) NOT NULL,
	MiddleName NVARCHAR(16),
	LastName NVARCHAR(32) NOT NULL,
	Gender CHAR(1) NOT NULL,
	EmailAddress VARCHAR(254) NOT NULL,
	MobileNumber VARCHAR(15) NOT NULL,
	District VARCHAR(6) NOT NULL,
	Province VARCHAR(6) NOT NULL,
	Region VARCHAR(6) NOT NULL,
	Country CHAR(2) NOT NULL,
	PreferredCurrency CHAR(3) NOT NULL,
	PreferredLanguage CHAR(2) NOT NULL,
	HasEmailAddressBeenVerified BIT NOT NULL CONSTRAINT DF_Business_Customer_HasEmailBeenVerified DEFAULT 0,
	IsLocked BIT NOT NULL CONSTRAINT DF_Business_Customer_IsLocked DEFAULT 0,
	IsActive BIT NOT NULL CONSTRAINT DF_Business_Customer_IsActive DEFAULT 1,
	CONSTRAINT PK_Business_Customer PRIMARY KEY (Id)
)
CREATE TABLE Business.CustomerQuestion
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Business_CustomerQuestion_Id DEFAULT NEWID(),
	Customer UNIQUEIDENTIFIER NOT NULL,
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	Property UNIQUEIDENTIFIER NOT NULL,
	Question NVARCHAR(2048) NOT NULL,
	Answer NVARCHAR(MAX) NULL CONSTRAINT CHK_Business_CustomerQuestion_Answer CHECK (LEN(Answer) <= 65535),
	QuestionTimeStamp DATETIME NOT NULL CONSTRAINT DF_Business_CustomerQuestion_QuestionTimeStamp DEFAULT GETUTCDATE(),
	AnswerTimeStamp DATETIME NULL,
	HasQuestionBeenRead BIT NOT NULL CONSTRAINT DF_Business_CustomerQuestion_HasQuestionBeenRead DEFAULT 0,
	HasAnswerBeenRead BIT NOT NULL CONSTRAINT DF_Business_CustomerQuestion_HasAnswerBeenRead DEFAULT 0,
	CONSTRAINT PK_Business_CustomerQuestion PRIMARY KEY (Id)
)
CREATE TABLE Business.[Partner]
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Business_Partner_Id DEFAULT NEWID(),
	Username NVARCHAR(32) NOT NULL,
	[Password] BINARY(64) NOT NULL,
	FirstName NVARCHAR(16) NOT NULL,
	MiddleName NVARCHAR(16),
	LastName NVARCHAR(32) NOT NULL,
	Gender CHAR(1) NOT NULL,
	EmailAddress VARCHAR(254) NOT NULL,
	MobileNumber VARCHAR(15) NOT NULL,
	CompanyName NVARCHAR(32) NOT NULL,
	[Address] NVARCHAR(32) NOT NULL,
	District VARCHAR(6) NOT NULL,
	Province VARCHAR(6) NOT NULL,
	Region VARCHAR(6) NOT NULL,
	Country CHAR(2) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	Website VARCHAR(2084) NOT NULL,
	PreferredCurrency CHAR(3) NOT NULL,
	PreferredLanguage CHAR(2) NOT NULL,
	StripeId VARCHAR(255),
	HasEmailAddressBeenVerified BIT NOT NULL CONSTRAINT DF_Business_Partner_HasEmailBeenVerified DEFAULT 0,
	IsLocked BIT NOT NULL CONSTRAINT DF_Business_Partner_IsLocked DEFAULT 0,
	IsActive BIT NOT NULL CONSTRAINT DF_Business_Partner_IsActive DEFAULT 1,
	CONSTRAINT PK_Business_Partner PRIMARY KEY (Id)
)
CREATE TABLE Business.Property
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Business_Property_Id DEFAULT NEWID(),
	[Name] NVARCHAR(32) NOT NULL,
	[Type] TINYINT NOT NULL,
	[Address] NVARCHAR(32) NOT NULL,
	District VARCHAR(6) NOT NULL,
	Province VARCHAR(6) NOT NULL,
	Region VARCHAR(6) NOT NULL,
	Country CHAR(2) NOT NULL,
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	PublishMode TINYINT,
	HasBeenPaid BIT NOT NULL CONSTRAINT DF_Business_Property_HasBeenPaid DEFAULT 0,
	HasBeenReviewed BIT NOT NULL CONSTRAINT DF_Business_Property_HasBeenReviewed DEFAULT 0,
	HasBeenPublished BIT NOT NULL CONSTRAINT DF_Business_Property_HasBeenPublished DEFAULT 0,
	IsActive BIT NOT NULL CONSTRAINT DF_Business_Property_IsActive DEFAULT 1,
	CONSTRAINT FK_Business_Property PRIMARY KEY (Id)
)
CREATE TABLE Business.PropertyFeature
(
	Id TINYINT NOT NULL IDENTITY(1, 1),
	CONSTRAINT PK_Business_PropertyFeature PRIMARY KEY (Id)
)
CREATE TABLE Business.PropertyFeatureDetail
(
	Property UNIQUEIDENTIFIER NOT NULL,
	Feature TINYINT NOT NULL,
	[Value] NVARCHAR(32) NOT NULL,
	CONSTRAINT PK_Business_PropertyFeatureDetail PRIMARY KEY (Property, Feature)
)
CREATE TABLE Business.PropertyPicture
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Business_PropertyPicture_Id DEFAULT NEWID(),
	Property UNIQUEIDENTIFIER NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,
	CONSTRAINT PK_Business_PropertyPicture PRIMARY KEY (Id, Property)
)
CREATE TABLE Business.PropertyType
(
	Id TINYINT NOT NULL IDENTITY(1, 1),
	CONSTRAINT PK_Business_PropertyType PRIMARY KEY (Id)
)
CREATE TABLE Business.PublishMode
(
	Id TINYINT NOT NULL IDENTITY(1, 1),
	Currency CHAR(3) NOT NULL,
	Cost DECIMAL(16, 2) NOT NULL,
	CONSTRAINT PK_Business_PublishMode PRIMARY KEY (Id)
)
GO
CREATE TABLE [Geography].Country
(
	Id CHAR(2) NOT NULL,
	PredominantCurrency CHAR(3) NOT NULL,
	PredominantLanguage CHAR(2) NOT NULL,
	CONSTRAINT PK_Geography_Country PRIMARY KEY (Id)
)
CREATE TABLE [Geography].CountrySupportedCurrency
(
	Country CHAR(2) NOT NULL,
	Currency CHAR(3) NOT NULL,
	CONSTRAINT PK_Geography_CountrySupportedCurrency PRIMARY KEY (Country, Currency)
)
CREATE TABLE [Geography].CountrySupportedLanguage
(
	Country CHAR(2) NOT NULL,
	Language CHAR(2) NOT NULL,
	CONSTRAINT PK_Geography_CountrySupportedLanguage PRIMARY KEY (Country, Language)
)
CREATE TABLE [Geography].Currency
(
	Id CHAR(3) NOT NULL,
	Symbol NVARCHAR(4) NOT NULL,
	CONSTRAINT PK_Geography_Currency PRIMARY KEY (Id)
)
CREATE TABLE [Geography].District
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	Province VARCHAR(6) NOT NULL,
	CONSTRAINT PK_Geography_District PRIMARY KEY (Country, Code)
)
CREATE TABLE [Geography].[Language]
(
	Id CHAR(2) NOT NULL,
	CONSTRAINT PK_Geography_Language PRIMARY KEY (Id)
)
CREATE TABLE [Geography].Province
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	Region VARCHAR(6) NOT NULL,
	CONSTRAINT PK_Geography_Province PRIMARY KEY (Country, Code)
)
CREATE TABLE [Geography].Region
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	CONSTRAINT PK_Geography_Region PRIMARY KEY (Country, Code)
)
GO
CREATE TABLE Localization.Country
(
	Id CHAR(2) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Country PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.Currency
(
	Id CHAR(3) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Currency PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.District
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_District PRIMARY KEY (Country, Code, [Language])
)
CREATE TABLE Localization.Gender
(
	Id CHAR(1) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Gender PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.[Language]
(
	Id CHAR(2) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Language PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.PropertyFeature
(
	Id TINYINT NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_PropertyFeature PRIMARY KEY (Id, Language)
)
CREATE TABLE Localization.PropertyType
(
	Id TINYINT NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_PropertyType PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.Province
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Province PRIMARY KEY (Country, Code, [Language])
)
CREATE TABLE Localization.PublishMode
(
	Id TINYINT NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_PublishMode PRIMARY KEY (Id, [Language])
)
CREATE TABLE Localization.Region
(
	Country CHAR(2) NOT NULL,
	Code VARCHAR(6) NOT NULL,
	[Language] CHAR(2) NOT NULL,
	DisplayName NVARCHAR(64) NOT NULL,
	CONSTRAINT PK_Localization_Region PRIMARY KEY (Country, Code, [Language])
)
CREATE TABLE [Parameters].Gender
(
	Id CHAR(1) NOT NULL,
	CONSTRAINT PK_Parameters_Gender PRIMARY KEY (Id)
)
GO
CREATE TABLE Payments.PartnerCard
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Payments_PartnerCard_Id DEFAULT NEWID(),
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	StripeId VARCHAR(255) NOT NULL,
	CONSTRAINT PK_Payments_PartnerCard PRIMARY KEY (Id)
)
CREATE TABLE Payments.PartnerInvoice
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Payments_PartnerInvoice_Id DEFAULT NEWID(),
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	[TimeStamp] DATETIME NOT NULL CONSTRAINT DF_Payments_PartnerInvoice_TimeStamp DEFAULT GETUTCDATE(),
	Currency CHAR(3) NOT NULL,
	StripeId VARCHAR(255) NOT NULL,
	CONSTRAINT PK_Payments_PartnerInvoice PRIMARY KEY (Id)
)
CREATE TABLE Payments.PartnerInvoiceDetail
(
	Invoice UNIQUEIDENTIFIER NOT NULL,
	Property UNIQUEIDENTIFIER NOT NULL,
	PublishMode TINYINT NOT NULL,
	Cost DECIMAL(18, 4) NOT NULL,
	CONSTRAINT PK_Payments_PartnerInvoiceDetail PRIMARY KEY (Invoice, Property)
)
GO
CREATE TABLE [Security].PartnerEmailVerification
(
	Id BINARY(64) NOT NULL,
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	EmailAddress VARCHAR(254) NOT NULL,
	ExpiresOn DATETIME,
	IsActive BIT NOT NULL CONSTRAINT DF_Security_PartnerEmailVerification_IsActive DEFAULT 1,
	CONSTRAINT PK_Security_PartnerEmailVerification PRIMARY KEY (Id)
)
CREATE TABLE [Security].PartnerLoginAttempt
(
	Id UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_Security_PartnerLoginAttempt_Id DEFAULT NEWID(),
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	IPAddress VARCHAR(45) NOT NULL,
	[TimeStamp] DATETIME NOT NULL CONSTRAINT DF_Security_PartnerLoginAttempt_TimeStamp DEFAULT GETUTCDATE(),
	CONSTRAINT PK_Security_PartnerLoginAttempt PRIMARY KEY (Id)
)
CREATE TABLE [Security].PartnerSession
(
	Id BINARY(64) NOT NULL,
	[Partner] UNIQUEIDENTIFIER NOT NULL,
	IPAddress VARCHAR(45) NOT NULL,
	LoggedAt DATETIME NOT NULL CONSTRAINT DF_Security_PartnerSession_LoggedAt DEFAULT GETUTCDATE(),
	ExpiresOn DATETIME,
	IsActive BIT NOT NULL CONSTRAINT DF_Security_PartnerSession_IsActive DEFAULT 1,
	CONSTRAINT PK_Security_PartnerSession PRIMARY KEY (Id)
)
GO

ALTER TABLE Business.CurrencyExchange ADD CONSTRAINT FK_Business_CurrencyExchange_From FOREIGN KEY ([From]) REFERENCES [Geography].Currency
ALTER TABLE Business.CurrencyExchange ADD CONSTRAINT FK_Business_CurrencyExchange_To FOREIGN KEY ([To]) REFERENCES [Geography].Currency
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_Gender FOREIGN KEY (Gender) REFERENCES [Parameters].Gender
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_District FOREIGN KEY (Country, District) REFERENCES [Geography].District
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_Province FOREIGN KEY (Country, Province) REFERENCES [Geography].Province
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_Region FOREIGN KEY (Country, Region) REFERENCES [Geography].Region
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_PreferredCurrency FOREIGN KEY (PreferredCurrency) REFERENCES [Geography].Currency
ALTER TABLE Business.Customer ADD CONSTRAINT FK_Business_Customer_PreferredLanguage FOREIGN KEY (PreferredLanguage) REFERENCES [Geography].[Language]
ALTER TABLE Business.Customer ADD CONSTRAINT UQ_Business_Customer_Username UNIQUE (Username)
ALTER TABLE Business.Customer ADD CONSTRAINT UQ_Business_Customer_EmailAddress UNIQUE (EmailAddress)
ALTER TABLE Business.CustomerQuestion ADD CONSTRAINT FK_Business_CustomerQuestion_Customer FOREIGN KEY (Customer) REFERENCES Business.Customer
ALTER TABLE Business.CustomerQuestion ADD CONSTRAINT FK_Business_CustomerQuestion_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE Business.CustomerQuestion ADD CONSTRAINT FK_Business_CustomerQuestion_Property FOREIGN KEY (Property) REFERENCES Business.Property
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_Gender FOREIGN KEY (Gender) REFERENCES [Parameters].Gender
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_District FOREIGN KEY (Country, District) REFERENCES [Geography].District
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_Province FOREIGN KEY (Country, Province) REFERENCES [Geography].Province
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_Region FOREIGN KEY (Country, Region) REFERENCES [Geography].Region
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_PreferredCurrency FOREIGN KEY (PreferredCurrency) REFERENCES [Geography].Currency
ALTER TABLE Business.[Partner] ADD CONSTRAINT FK_Business_Partner_PreferredLanguage FOREIGN KEY (PreferredLanguage) REFERENCES [Geography].[Language]
ALTER TABLE Business.[Partner] ADD CONSTRAINT UQ_Business_Partner_Username UNIQUE (Username)
ALTER TABLE Business.[Partner] ADD CONSTRAINT UQ_Business_Partner_EmailAddress UNIQUE (EmailAddress)
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_Type FOREIGN KEY (Type) REFERENCES Business.PropertyType
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_District FOREIGN KEY (Country, District) REFERENCES [Geography].District
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_Province FOREIGN KEY (Country, Province) REFERENCES [Geography].Province
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_Region FOREIGN KEY (Country, Region) REFERENCES [Geography].Region
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE Business.Property ADD CONSTRAINT FK_Business_Property_PublishMode FOREIGN KEY (PublishMode) REFERENCES Business.PublishMode
ALTER TABLE Business.PropertyFeatureDetail ADD CONSTRAINT FK_Business_PropertyFeatureDetail_Property FOREIGN KEY (Property) REFERENCES Business.Property
ALTER TABLE Business.PropertyFeatureDetail ADD CONSTRAINT FK_Business_PropertyFeatureDetail_Feature FOREIGN KEY (Feature) REFERENCES Business.PropertyFeature
ALTER TABLE Business.PropertyPicture ADD CONSTRAINT FK_Business_PropertyPicture_Property FOREIGN KEY (Property) REFERENCES Business.Property
ALTER TABLE Business.PublishMode ADD CONSTRAINT FK_Business_PublishMode_Currency FOREIGN KEY (Currency) REFERENCES [Geography].Currency
GO
ALTER TABLE [Geography].Country ADD CONSTRAINT FK_Geography_Country_PredominantCurrency FOREIGN KEY (PredominantCurrency) REFERENCES [Geography].Currency
ALTER TABLE [Geography].Country ADD CONSTRAINT FK_Geography_Country_PredominantLanguage FOREIGN KEY (PredominantLanguage) REFERENCES [Geography].[Language]
ALTER TABLE [Geography].CountrySupportedCurrency ADD CONSTRAINT FK_Geography_CountrySupportedCurrency_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE [Geography].CountrySupportedCurrency ADD CONSTRAINT FK_Geography_CountrySupportedCurrency_Currency FOREIGN KEY (Currency) REFERENCES [Geography].Currency
ALTER TABLE [Geography].CountrySupportedLanguage ADD CONSTRAINT FK_Geography_CountrySupportedLanguage_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE [Geography].CountrySupportedLanguage ADD CONSTRAINT FK_Geography_CountrySupportedLanguage_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE [Geography].District ADD CONSTRAINT FK_Geography_District_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE [Geography].District ADD CONSTRAINT FK_Geography_District_Province FOREIGN KEY (Country, Province) REFERENCES [Geography].Province
ALTER TABLE [Geography].Province ADD CONSTRAINT FK_Geography_Province_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
ALTER TABLE [Geography].Province ADD CONSTRAINT FK_Geography_Province_Region FOREIGN KEY (Country, Region) REFERENCES [Geography].Region
ALTER TABLE [Geography].Region ADD CONSTRAINT FK_Geography_Region_Country FOREIGN KEY (Country) REFERENCES [Geography].Country
GO
ALTER TABLE Localization.Country ADD CONSTRAINT FK_Localization_Country_Id FOREIGN KEY (Id) REFERENCES [Geography].Country
ALTER TABLE Localization.Country ADD CONSTRAINT FK_Localization_Country_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.Currency ADD CONSTRAINT FK_Localization_Currency_Id FOREIGN KEY (Id) REFERENCES [Geography].Currency
ALTER TABLE Localization.Currency ADD CONSTRAINT FK_Localization_Currency_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.District ADD CONSTRAINT [FK_Localization_District_Country+Code] FOREIGN KEY (Country, Code) REFERENCES [Geography].District
ALTER TABLE Localization.District ADD CONSTRAINT FK_Localization_District_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.Gender ADD CONSTRAINT FK_Localization_Gender_Id FOREIGN KEY (Id) REFERENCES [Parameters].Gender
ALTER TABLE Localization.Gender ADD CONSTRAINT FK_Localization_Gender_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.[Language] ADD CONSTRAINT FK_Localization_Language_Id FOREIGN KEY (Id) REFERENCES [Geography].[Language]
ALTER TABLE Localization.[Language] ADD CONSTRAINT FK_Localization_Language_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.PropertyFeature ADD CONSTRAINT FK_Localization_PropertyFeature_Id FOREIGN KEY (Id) REFERENCES Business.PropertyFeature
ALTER TABLE Localization.PropertyFeature ADD CONSTRAINT FK_Localization_PropertyFeature_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.PropertyType ADD CONSTRAINT FK_Localization_PropertyType_Id FOREIGN KEY (Id) REFERENCES Business.PropertyType
ALTER TABLE Localization.PropertyType ADD CONSTRAINT FK_Localization_PropertyType_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.Province ADD CONSTRAINT [FK_Localization_Province_Country+Code] FOREIGN KEY (Country, Code) REFERENCES [Geography].Province
ALTER TABLE Localization.Province ADD CONSTRAINT FK_Localization_Province_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.PublishMode ADD CONSTRAINT FK_Localization_PublishMode_Id FOREIGN KEY (Id) REFERENCES Business.PublishMode
ALTER TABLE Localization.PublishMode ADD CONSTRAINT FK_Localization_PublishMode_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
ALTER TABLE Localization.Region ADD CONSTRAINT [FK_Localization_Region_Country+Code] FOREIGN KEY (Country, Code) REFERENCES [Geography].Region
ALTER TABLE Localization.Region ADD CONSTRAINT FK_Localization_Region_Language FOREIGN KEY ([Language]) REFERENCES [Geography].[Language]
GO
ALTER TABLE [Security].PartnerEmailVerification ADD CONSTRAINT FK_Security_PartnerEmailVerification_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE [Security].PartnerLoginAttempt ADD CONSTRAINT FK_Security_PartnerLoginAttempt_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE [Security].PartnerSession ADD CONSTRAINT FK_Security_PartnerSession_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
GO
ALTER TABLE Payments.PartnerCard ADD CONSTRAINT FK_Payments_PartnerCard_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE Payments.PartnerInvoice ADD CONSTRAINT FK_Payments_PartnerInvoice_Partner FOREIGN KEY ([Partner]) REFERENCES Business.[Partner]
ALTER TABLE Payments.PartnerInvoice ADD CONSTRAINT FK_Payments_PartnerInvoice_Currency FOREIGN KEY (Currency) REFERENCES [Geography].Currency
ALTER TABLE Payments.PartnerInvoiceDetail ADD CONSTRAINT FK_Payments_PartnerInvoiceDetail_Invoice FOREIGN KEY (Invoice) REFERENCES Payments.PartnerInvoice
ALTER TABLE Payments.PartnerInvoiceDetail ADD CONSTRAINT FK_Payments_PartnerInvoiceDetail_Property FOREIGN KEY (Property) REFERENCES Business.Property
ALTER TABLE Payments.PartnerInvoiceDetail ADD CONSTRAINT FK_Payments_PartnerInvoiceDetail_PublishMode FOREIGN KEY (PublishMode) REFERENCES Business.PublishMode
GO