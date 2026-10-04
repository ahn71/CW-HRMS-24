using System.Drawing;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace SigmaERP.classes
{
    // Excel version of the HTML report header (brand on both sides, company, title, meta line) and signature footer
    public static class ReportExcelHeader
    {
        private static readonly Color BrandColor = Color.FromArgb(150, 132, 67);
        private static readonly Color MutedColor = Color.FromArgb(88, 101, 121);
        private static readonly Color SubtitleColor = Color.FromArgb(85, 118, 67);
        private static readonly Color HeaderFill = Color.FromArgb(223, 228, 236);

        // Writes rows 1-5 and returns the first free row.
        public static int Write(ExcelWorksheet ws, int totalColumns, string company, string address, string title, string subtitle, string metaLine)
        {
            int side = totalColumns >= 9 ? 3 : 1;
            int midFrom = side + 1, midTo = totalColumns - side;

            Brand(ws, 1, side, "ESTD. 1964");
            Brand(ws, totalColumns - side + 1, totalColumns, "BEACH RESORT");

            Line(ws, 1, midFrom, midTo, company, 16, true, Color.Black);
            Line(ws, 2, midFrom, midTo, address, 10, false, MutedColor);
            Line(ws, 3, midFrom, midTo, (title ?? "").ToUpperInvariant(), 16, true, Color.Black);
            Line(ws, 4, midFrom, midTo, subtitle, 11, true, SubtitleColor);
            Line(ws, 5, 1, totalColumns, metaLine, 11, true, Color.Black);

            var meta = ws.Cells[5, 1, 5, totalColumns];
            meta.Style.Border.Top.Style = ExcelBorderStyle.Medium;
            meta.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
            ws.Row(1).Height = 24;
            ws.Row(3).Height = 24;
            ws.Row(5).Height = 22;
            return 6;
        }

        // Header row of the data table: bold, shaded, bordered, wrapped.
        public static void StyleTableHeader(ExcelRange range)
        {
            range.Style.Font.Bold = true;
            range.Style.Fill.PatternType = ExcelFillStyle.Solid;
            range.Style.Fill.BackgroundColor.SetColor(HeaderFill);
            range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            range.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
            range.Style.WrapText = true;
        }

        public static void Borders(ExcelRange range)
        {
            range.Style.Border.Top.Style = ExcelBorderStyle.Thin;
            range.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
            range.Style.Border.Left.Style = ExcelBorderStyle.Thin;
            range.Style.Border.Right.Style = ExcelBorderStyle.Thin;
        }

        // Signature labels spread evenly across the sheet, each with a line above it.
        public static void WriteSignatures(ExcelWorksheet ws, int row, int totalColumns, params string[] labels)
        {
            if (labels.Length == 0) return;
            int segment = totalColumns / labels.Length;
            if (segment < 1) segment = 1;
            for (int i = 0; i < labels.Length; i++)
            {
                int from = i * segment + 1, to = i == labels.Length - 1 ? totalColumns : (i + 1) * segment;
                if (to - from >= 2) { from++; to--; }
                if (from > totalColumns) break;
                var cell = ws.Cells[row, from, row, to];
                cell.Merge = true;
                cell.Value = labels[i];
                cell.Style.WrapText = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Top;
                cell.Style.Border.Top.Style = ExcelBorderStyle.Thin;
            }
            ws.Row(row).Height = 30;
        }

        private static void Brand(ExcelWorksheet ws, int fromCol, int toCol, string sub)
        {
            ws.Cells[1, fromCol, 4, toCol].Merge = true;
            var cell = ws.Cells[1, fromCol];
            cell.IsRichText = true;
            var main = cell.RichText.Add("SAYEMAN");
            main.FontName = "Georgia";
            main.Size = 22;
            main.Color = BrandColor;
            var small = cell.RichText.Add("\n" + sub);
            small.FontName = "Georgia";
            small.Size = 9;
            small.Bold = true;
            small.Color = BrandColor;
            var range = ws.Cells[1, fromCol, 4, toCol];
            range.Style.WrapText = true;
            range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            range.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        }

        private static void Line(ExcelWorksheet ws, int row, int fromCol, int toCol, string text, float size, bool bold, Color color)
        {
            if (toCol < fromCol) toCol = fromCol;
            var range = ws.Cells[row, fromCol, row, toCol];
            range.Merge = true;
            range.Value = text ?? "";
            range.Style.Font.Size = size;
            range.Style.Font.Bold = bold;
            range.Style.Font.Color.SetColor(color);
            range.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
            range.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
        }
    }
}
