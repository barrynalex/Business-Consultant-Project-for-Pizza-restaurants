USE [BUDT703_Project_0506_06];

BEGIN TRANSACTION;

DROP TABLE IF EXISTS [Master_Lee's.Order];
DROP TABLE IF EXISTS [Master_Lee's.MenuCuisine];
DROP TABLE IF EXISTS [Master_Lee's.Menu];
DROP TABLE IF EXISTS [Master_Lee's.Employ];
DROP TABLE IF EXISTS [Master_Lee's.DeliveryPlatform];
DROP TABLE IF EXISTS [Master_Lee's.Review];
DROP TABLE IF EXISTS [Master_Lee's.Customer];
DROP TABLE IF EXISTS [Master_Lee's.Restaurant];

CREATE TABLE [Master_Lee's.Restaurant] (
	rstId CHAR(5) NOT NULL,
	rstName VARCHAR(20),
	rstCapacity DECIMAL(3,0),
	rstDistance DECIMAL(5,2),
	rstStreet VARCHAR(30),
	rstLatitude DECIMAL(8,2),
	rstLongtitude DECIMAL(8,2),
	rstCity VARCHAR(20),
	rstZip CHAR(5),
	rstParking BIT,
	rstWiFi BIT,
    CONSTRAINT pk_Restaurant_rstId PRIMARY KEY (rstId)
    );

CREATE TABLE [Master_Lee's.Customer] (
    cstId CHAR(5) NOT NULL,
    cstName VARCHAR(20),
    cstGender BIT,
    cstAge VARCHAR(5),
    CONSTRAINT pk_Customers_cstId PRIMARY KEY (cstId)
    );

CREATE TABLE [Master_Lee's.Review] (
    rvwRating DECIMAL(1,0) NOT NULL,
    rvwStatement VARCHAR(1000),
    rvwDate DATE,
    rstId CHAR(5) NOT NULL,
    cstId CHAR(5) NOT NULL,
    CONSTRAINT pk_Review_rstId_cstId PRIMARY KEY (rstId, cstId),
    CONSTRAINT fk_Review_rstId FOREIGN KEY (rstId)
		REFERENCES [Master_Lee's.Restaurant] (rstId)
		ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT fk_Review_cstId FOREIGN KEY (cstId)
		REFERENCES [Master_Lee's.Customer] (cstId)
		ON DELETE CASCADE ON UPDATE NO ACTION,
    )

CREATE TABLE [Master_Lee's.DeliveryPlatform] (
    pltName VARCHAR(20) NOT NULL,
    pltWebsite XML,
    CONSTRAINT pk_DeliveryPlatform_pltName PRIMARY KEY (pltName),
    );

CREATE TABLE [Master_Lee's.Employ] (
    rstId CHAR(5) NOT NULL,
    pltName VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Employ_rstId_pltName PRIMARY KEY (rstId, pltName),
    CONSTRAINT fk_Employ_rstId FOREIGN KEY (rstId)
		REFERENCES [Master_Lee's.Restaurant] (rstId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Employ_pltName FOREIGN KEY (pltName)
		REFERENCES [Master_Lee's.DeliveryPlatform] (pltName)
		ON DELETE CASCADE ON UPDATE CASCADE,
    );

CREATE TABLE [Master_Lee's.Menu] (
    rstId CHAR(5) NOT NULL,
    mnuId CHAR(5) NOT NULL,
    mnuPriceRange DECIMAL(4,2),
    mnuDrink BIT,
    CONSTRAINT pk_Menu_rstId_mnuId PRIMARY KEY (rstId, mnuId),
    CONSTRAINT fk_Menu_rstId FOREIGN KEY (rstId)
		REFERENCES [Master_Lee's.Restaurant] (rstId)
		ON DELETE CASCADE ON UPDATE CASCADE,
    );

CREATE TABLE [Master_Lee's.MenuCuisine] (
    rstId CHAR(5) NOT NULL,
    mnuId CHAR(5) NOT NULL,
    mnuCuisine VARCHAR(30) NOT NULL,
    CONSTRAINT pk_MenuCuisine_rstId_mnuId_mnuCuisine PRIMARY KEY (rstId, mnuId, mnuCuisine),
    CONSTRAINT fk_MenuCuisine_rstId_mnuId FOREIGN KEY (rstId, mnuId)
		REFERENCES [Master_Lee's.Menu] (rstId, mnuId)
		ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE [Master_Lee's.Order] (
	rstId CHAR(5) NOT NULL,
    cstId CHAR(5) NOT NULL,
	CONSTRAINT pk_Order_rstId_cstId PRIMARY KEY (rstId, cstId),
	CONSTRAINT fk_Order_rstId FOREIGN KEY (rstId)
		REFERENCES [Master_Lee's.Restaurant] (rstId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Order_cstId FOREIGN KEY (cstId)
		REFERENCES [Master_Lee's.Customer] (cstId)
		ON DELETE NO ACTION ON UPDATE NO ACTION
	);

COMMIT;
