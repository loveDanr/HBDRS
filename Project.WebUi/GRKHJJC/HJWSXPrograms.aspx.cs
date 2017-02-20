using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.GRKHJJC
{
    public partial class HJWSXPrograms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            MergeRow(this.GridView1, 0);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="gv"></param>
        /// <param name="currentCol"></param>
        private void MergeRow(GridView gv, int currentCol)
        {
            if(gv.Rows.Count < 1 || currentCol > gv.Rows[0].Cells.Count -1)
            {
                return;
            }
            TableCell oldTC = gv.Rows[0].Cells[currentCol];
            for (int i = 1; i < gv.Rows.Count; i++)
            {
                TableCell tc = gv.Rows[i].Cells[currentCol];
                if (oldTC.Text == tc.Text)
                {
                    tc.Visible = false;
                    if (oldTC.RowSpan == 0)
                    {
                        oldTC.RowSpan = 1;
                    }
                    oldTC.RowSpan++;
                    oldTC.VerticalAlign = VerticalAlign.Middle;
                }
                else
                {
                    oldTC = tc;
                }
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="gv"></param>
        /// <param name="currentCol"></param>
        /// <param name="startRow"></param>
        /// <param name="endRow"></param>
        private void MergeRow(GridView gv, int currentCol, int startRow, int endRow)
        {
            for (int rowIndex = endRow; rowIndex >= startRow; rowIndex--)
            {
                GridViewRow currentRow = gv.Rows[rowIndex];
                GridViewRow prevRow = gv.Rows[rowIndex + 1];
                if (!string.IsNullOrWhiteSpace(currentRow.Cells[currentCol].Text))
                {
                    if (currentRow.Cells[currentCol].Text == prevRow.Cells[currentCol].Text)
                    {
                        currentRow.Cells[currentCol].RowSpan = prevRow.Cells[currentCol].RowSpan < 1 ? 2 : prevRow.Cells[currentCol].RowSpan + 1;
                        prevRow.Cells[currentCol].Visible = false;

                    }
                }
            }
        }
    }
}