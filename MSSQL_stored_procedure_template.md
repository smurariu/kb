```sql
/***************************************************************************************************
  Object Name : DELETE_CUSTOMER_BY_ID
  Created by  : You 
  Date        : 09-12-2016
  Purpose     : Delete a customer by id

  09-12-2016 - You: Implemented the procedure
  
***************************************************************************************************/

/* Schema dependencies  */

--IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Schema Name')) 
--BEGIN
--    EXEC ('CREATE SCHEMA [Schema Name] AUTHORIZATION [dbo]')
--END

------------------------------------------------------------------------
-->>					Procedure Statement							<<--
------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[DELETE_CUSTOMER_BY_ID]
    @CUSTOMER_ID INT
AS
BEGIN
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    BEGIN TRY
        --BEGIN TRAN  /* Optional*/

        /* Internal Parameters */
                    
        DECLARE @ErrorMessage NVARCHAR(4000)

        ------------------------------------------------------------------------
        -->>						CODE									<<--
        ------------------------------------------------------------------------


        
        ------------------------------------------------------------------------
        -->>					ERROR HANDLING								<<--
        ------------------------------------------------------------------------

        GOTO SQLStatementComplete

        QuitWithError:

        SET @ErrorMessage = ERROR_MESSAGE()
        RAISERROR(@ErrorMessage,16,1)

        SQLStatementComplete:

        --COMMIT TRAN /* Optional*/
    END TRY
    BEGIN CATCH

        -- Raise error
        SET @ErrorMessage = ERROR_MESSAGE()
        RAISERROR(@ErrorMessage,16,1)

    END CATCH
END
GO
```