using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Project.WebUi.App_Code;

namespace Project.WebUi.MYDYS
{
    public partial class index :MyBasePage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string startyear = DateTime.Today.ToString("yyyy-01-01");
            string halfyear = DateTime.Today.ToString("yyyy-06-30");

            if (DateTime.Now.CompareTo(DateTime.Parse(halfyear)) < 0)
            {
                SqlDataSource1.SelectCommand = "select count(*) from HLX_MYDYS where 编号='" + loginUser.UserId + "' and 时间 >'" + startyear + "' and 时间 <='" + halfyear + "'";
            }
            else if (DateTime.Now.CompareTo(DateTime.Parse(halfyear)) > 0)
            {
                SqlDataSource1.SelectCommand = "select count(*) from HLX_MYDYS where 编号='" + loginUser.UserId + "' and 时间 >'" + halfyear + "'";
            }
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            if (!dv.Table.Rows[0][0].Equals(0))
            {
                Response.Redirect("ok.html", true);
            }
            
        }



        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            String sex = "女";
            if (sex1.Checked == true)
            {
                sex = "男";
            }
            String year = "1";
            if (age.Text != null)
            {
                year = age.Text.ToString(); ;
            }
            int r1 = 0;
            if (R11.Checked == true)
            {
                r1 = 10;
            }
            if (R12.Checked == true)
            {
                r1 = 8;
            }
            else if (R13.Checked == true)
            {
                r1 = 2;
            }

            int r2 = 0;
            if (R21.Checked == true)
            {
                r2 = 10;
            }
            if (R22.Checked == true)
            {
                r2 = 8;
            }
            else if (R23.Checked == true)
            {
                r2 = 2;
            }

            int r3 = 0;
            if (R31.Checked == true)
            {
                r3 = 10;
            }
            if (R32.Checked == true)
            {
                r3 = 8;
            }
            else if (R33.Checked == true)
            {
                r3 = 2;
            }

            int r4 = 0;
            if (R41.Checked == true)
            {
                r4 = 10;
            }
            if (R42.Checked == true)
            {
                r4 = 8;
            }
            else if (R43.Checked == true)
            {
                r4 = 2;
            }

            int r5 = 0;
            if (R51.Checked == true)
            {
                r5 = 10;
            }
            if (R52.Checked == true)
            {
                r5 = 8;
            }
            else if (R53.Checked == true)
            {
                r5 = 2;
            }

            int r6 = 0;
            if (R61.Checked == true)
            {
                r6 = 10;
            }
            if (R62.Checked == true)
            {
                r6 = 8;
            }
            else if (R63.Checked == true)
            {
                r6 = 2;
            }

            int r7 = 0;
            if (R71.Checked == true)
            {
                r7 = 10;
            }
            if (R72.Checked == true)
            {
                r7 = 8;
            }
            else if (R73.Checked == true)
            {
                r7 = 2;
            }

            int r8 = 0;
            if (R81.Checked == true)
            {
                r8 = 10;
            }
            if (R82.Checked == true)
            {
                r8 = 8;
            }
            else if (R83.Checked == true)
            {
                r8 = 2;
            }

            int r9 = 0;
            if (R91.Checked == true)
            {
                r9 = 10;
            }
            if (R92.Checked == true)
            {
                r9 = 8;
            }
            else if (R93.Checked == true)
            {
                r9 = 2;
            }

            int r10 = 0;
            if (R101.Checked == true)
            {
                r10 = 10;
            }
            if (R102.Checked == true)
            {
                r10 = 8;
            }
            else if (R103.Checked == true)
            {
                r10 = 2;
            }


            int total = 0;
            total = r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10;
            String SQLString = "insert into HLX_MYDYS values('" + loginUser.UserId + "','" + loginUser.UserName + "','" + loginUser.DeptId + "','" + sex + "','" + year + "'," + total + ",'" + TextBox1.Text + "','" + TextBox2.Text + "',getdate()," + r1;
            SQLString = SQLString + "," + r2;
            SQLString = SQLString + "," + r3;
            SQLString = SQLString + "," + r4;
            SQLString = SQLString + "," + r5;
            SQLString = SQLString + "," + r6;
            SQLString = SQLString + "," + r7;
            SQLString = SQLString + "," + r8;
            SQLString = SQLString + "," + r9;
            SQLString = SQLString + "," + r10 + ")";
            SqlDataSource1.InsertCommand = SQLString;
            SqlDataSource1.Insert();

            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r1 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='一'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r2 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='二'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r3 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='三'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r4 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='四'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r5 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='五'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r6 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='六'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r7 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='七'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r8 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='八'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r9 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='九'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r10 + " where yh='y' and 科室='" + loginUser.DeptId + "' and SUBJECT='十'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            Response.Redirect("ok.html", true);
        }
    }
}