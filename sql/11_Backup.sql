-- Full Backup
BACKUP DATABASE DM_FTI_DW
TO DISK = N'D:\Backup\DM_FTI_DW_Full.bak'
WITH
    COMPRESSION,
    INIT,
    NAME = N'Full Database Backup',
    STATS = 10;
GO

-- Differential Backup
BACKUP DATABASE DM_FTI_DW
TO DISK = N'D:\Backup\DM_FTI_DW_Diff.bak'
WITH
    DIFFERENTIAL,
    COMPRESSION,
    INIT,
    NAME = N'Differential Database Backup',
    STATS = 10;
GO

-- Transaction Log Backup
BACKUP LOG DM_FTI_DW
TO DISK = N'D:\Backup\DM_FTI_DW_Log.trn';
WITH
    COMPRESSION,
    INIT,
    NAME = N'Transaction Log Backup',
    STATS = 10;
GO

-- Schedule Backup Jobs
-- Full Backup: Weekly (Sunday 2 AM)
-- Differential Backup: Daily (2 AM)
-- Transaction Log Backup: Every 6 hours

-- Backup to Azure Blob Storage (Optional)
CREATE CREDENTIAL [AzureStorageCredential]
WITH 
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = '<SAS_TOKEN>';
GO

BACKUP DATABASE DM_FTI_DW
TO URL = N'https://[storage_account].blob.core.windows.net/backups/DM_FTI_DW.bak'
WITH 
    CREDENTIAL = 'AzureStorageCredential',
    COMPRESSION;
GO
