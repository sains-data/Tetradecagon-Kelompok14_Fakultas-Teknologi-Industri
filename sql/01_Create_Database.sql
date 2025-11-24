-- ===========================================
-- 01 - CREATE DATABASE FOR DATA MART FTI
-- ===========================================

CREATE DATABASE DM_FTI_DW
ON PRIMARY
(
    NAME = N'DM_FTI_DW_Data',
    FILENAME = N'D:\DataWarehouse\DM_FTI_DW_Data.mdf',
    SIZE = 512MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 128MB
)
LOG ON
(
    NAME = N'DM_FTI_DW_Log',
    FILENAME = N'E:\DataWarehouseLogs\DM_FTI_DW_Log.ldf',
    SIZE = 256MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 64MB
);
GO

USE DM_FTI_DW;
GO