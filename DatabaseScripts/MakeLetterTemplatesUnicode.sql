/* Run once against the HRMS database before saving Bengali templates. */
DECLARE @isNullable bit;
SELECT @isNullable = is_nullable
FROM sys.columns
WHERE object_id = OBJECT_ID(N'dbo.LetterTemplates')
  AND name = N'TemplateBodyHtml';

IF @isNullable IS NULL
    THROW 50001, 'dbo.LetterTemplates.TemplateBodyHtml was not found.', 1;

DECLARE @sql nvarchar(max) = N'ALTER TABLE dbo.LetterTemplates ALTER COLUMN TemplateBodyHtml NVARCHAR(MAX) '
    + CASE WHEN @isNullable = 1 THEN N'NULL' ELSE N'NOT NULL' END + N';';
EXEC sys.sp_executesql @sql;
