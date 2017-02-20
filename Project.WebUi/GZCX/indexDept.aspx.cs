using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using Project.WebUi.App_Code;

namespace Project.WebUi.GZCX
{
    public partial class indexDept : MyBasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxDateEdit1.DateTime = System.DateTime.Now.Date.AddMonths(-1).AddDays(-DateTime.Now.Day + 1);
                ASPxDateEdit2.DateTime = System.DateTime.Now;
            }
            Chax();
        }

        private string GetUserIDs()
        {
            string res = string.Empty;
            string filepath = Server.MapPath("userids.txt");
            if (!File.Exists(filepath))
            {
            }
            else
            {
                StreamReader sr = new StreamReader(filepath);
                try
                {
                    res = sr.ReadToEnd();
                    sr.Close();
                }
                finally
                {
                    sr.Close();
                }
            }
            return res;
        }
        protected void Chax()
        {

            string sc;
            string dept = string.Empty;
            string deptid = string.Empty;

            sc = "select DISTINCT [部门] from CWX_GZ WHERE 签字>='" + ASPxDateEdit1.DateTime.ToString("yyyyMM") + "' and 签字 <='" + ASPxDateEdit2.DateTime.ToString("yyyyMM") + "' AND 人员编号='" + loginUser.UserId + "'";
            SqlDataSource1.SelectCommand = sc;
            IEnumerator eunme = SqlDataSource1.Select(DataSourceSelectArguments.Empty).GetEnumerator();
            if (eunme.MoveNext())
            {
                dept = ((System.Data.DataRowView)(eunme.Current)).Row.ItemArray[0].ToString();
            }
            //判断是否具有查全科（大科室）的工资，否则不查找科室的parentid
            if (GetUserIDs().Contains(loginUser.UserId))
            {
                sc = " SELECT b.deptid FROM CWX_Dept a , cwx_dept b WHERE  a.parentdeptid = b.deptid AND  a.deptname= '" + dept + "'";
                SqlDataSource1.SelectCommand = sc;
                eunme = SqlDataSource1.Select(DataSourceSelectArguments.Empty).GetEnumerator();
                if (eunme.MoveNext())
                {
                    deptid = ((System.Data.DataRowView)(eunme.Current)).Row.ItemArray[0].ToString();

                }
            }
            if (!string.IsNullOrEmpty(deptid))
            {
                sc = "SELECT deptname FROM cwx_dept WHERE parentdeptid ='" + deptid + "'";
                SqlDataSource1.SelectCommand = sc;
                eunme = SqlDataSource1.Select(DataSourceSelectArguments.Empty).GetEnumerator();
                bool iFlag = true;
                while (eunme.MoveNext())
                {
                    if (iFlag)
                    {
                        dept = "'" + ((System.Data.DataRowView)(eunme.Current)).Row.ItemArray[0].ToString() + "'";
                        iFlag = false;
                        continue;
                    }
                    dept += ",";
                    dept += "'" + ((System.Data.DataRowView)(eunme.Current)).Row.ItemArray[0].ToString() + "'";

                }

            }
            else
            {
                dept = "'" + dept + "'";
            }
            sc = "select * from CWX_GZ where 签字>='" + ASPxDateEdit1.DateTime.ToString("yyyyMM") + "' and 签字 <='" + ASPxDateEdit2.DateTime.ToString("yyyyMM") + "' and 部门 in (" + dept + ")";
            SqlDataSource1.SelectCommand = sc;

            ASPxGridView1.DataBind();
        }


        protected void ASPxButton1_Click1(object sender, EventArgs e)
        {
            //Chax();
        }
        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            Chax();
            ASPxGridViewExporter1.WriteXlsToResponse();
        }
    }
}