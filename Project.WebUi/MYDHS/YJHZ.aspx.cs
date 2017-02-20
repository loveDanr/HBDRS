using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project.WebUi.MYDHS
{
    public partial class YJHZ : App_Code.MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxTimeEditStart.DateTime = System.DateTime.Now;
            }
            else
            {

                string startDate;
                string endDate;
                if (ASPxComboBoxHalfYear.Text == "下半年")
                {
                    startDate = ASPxTimeEditStart.DateTime.ToString("yyyy-7-1");
                    endDate = ASPxTimeEditStart.DateTime.ToString("yyyy-12-31");
                }
                else
                {
                    startDate = ASPxTimeEditStart.DateTime.ToString("yyyy-1-1");
                    endDate = ASPxTimeEditStart.DateTime.ToString("yyyy-6-30");
                }
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("startDate", System.Data.DbType.String, startDate);
                SqlDataSource1.SelectParameters.Add("endDate", System.Data.DbType.String, endDate);

                //全部
                if (ASPxComboBoxCategory.Value.ToString() == "0")
                {
                    SqlDataSource1.SelectCommand = "SELECT [意见建议] FROM [HLX_MYDYS] WHERE [意见建议] <> '' AND [意见建议] IS NOT NULL AND 时间 >=@startDate AND 时间<=@endDate  UNION ALL SELECT [意见建议] FROM [HLX_MYDHS] WHERE [意见建议] <> '' AND [意见建议] IS NOT NULL AND 时间 >=@startDate AND 时间<=@endDate";
                }
                //医生
                if (ASPxComboBoxCategory.Value.ToString() == "1")
                {
                    SqlDataSource1.SelectCommand = "SELECT [意见建议] FROM [HLX_MYDYS] WHERE [意见建议] <> '' AND [意见建议] IS NOT NULL AND 时间 >=@startDate AND 时间<=@endDate ";
                }
                //护士
                if (ASPxComboBoxCategory.Value.ToString() == "2")
                {
                    SqlDataSource1.SelectCommand = "SELECT [意见建议] FROM [HLX_MYDHS] WHERE [意见建议] <> '' AND [意见建议] IS NOT NULL AND 时间 >=@startDate AND 时间<=@endDate";
                }
            }
        }

        protected void ASPxButtonQuery_Click(object sender, EventArgs e)
        {

            ASPxDataView1.DataBind();
        }


        protected void ASPxDataView1_PageIndexChanging(object source, DevExpress.Web.DataViewPageEventArgs e)
        {
            ASPxDataView1.DataBind();
        }

    }
}