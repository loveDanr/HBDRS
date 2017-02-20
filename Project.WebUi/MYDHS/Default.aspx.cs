using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Project.WebUi.App_Code;

namespace Project.WebUi.MYDHS
{
    public partial class Default : MyBasePage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string  startyear = DateTime.Today.ToString("yyyy-01-01");
            string halfyear = DateTime.Today.ToString("yyyy-06-30");

            if (DateTime.Now.CompareTo(DateTime.Parse(halfyear)) < 0)
            {
                SqlDataSource1.SelectCommand = "select count(*) from HLX_MYDHS where 编号='" + loginUser.UserId + "' and 时间 >'" + startyear + "' and 时间 <='" + halfyear + "'";
            }
            else if (DateTime.Now.CompareTo(DateTime.Parse(halfyear)) > 0)
            {
                SqlDataSource1.SelectCommand = "select count(*) from HLX_MYDHS where 编号='" + loginUser.UserId + "' and 时间 >'" + halfyear + "'";
            }
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

            if (!dv.Table.Rows[0][0].Equals(0))
            {
                Response.Redirect("ok.htm", true);
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
                r1 = 5;
            }
            if (R12.Checked == true)
            {
                r1 = 4;
            }
            else if (R13.Checked == true)
            {
                r1 = 1;
            }

            int r2 = 0;
            if (R21.Checked == true)
            {
                r2 = 5;
            }
            if (R22.Checked == true)
            {
                r2 = 4;
            }
            else if (R23.Checked == true)
            {
                r2 = 1;
            }

            int r3 = 0;
            if (R31.Checked == true)
            {
                r3 = 5;
            }
            if (R32.Checked == true)
            {
                r3 = 4;
            }
            else if (R33.Checked == true)
            {
                r3 = 1;
            }

            int r4 = 0;
            if (R41.Checked == true)
            {
                r4 = 5;
            }
            if (R42.Checked == true)
            {
                r4 = 4;
            }
            else if (R43.Checked == true)
            {
                r4 = 1;
            }

            int r5 = 0;
            if (R51.Checked == true)
            {
                r5 = 5;
            }
            if (R52.Checked == true)
            {
                r5 = 4;
            }
            else if (R53.Checked == true)
            {
                r5 = 1;
            }

            int r6 = 0;
            if (R61.Checked == true)
            {
                r6 = 5;
            }
            if (R62.Checked == true)
            {
                r6 = 4;
            }
            else if (R63.Checked == true)
            {
                r6 = 1;
            }

            int r7 = 0;
            if (R71.Checked == true)
            {
                r7 = 5;
            }
            if (R72.Checked == true)
            {
                r7 = 4;
            }
            else if (R73.Checked == true)
            {
                r7 = 1;
            }

            int r8 = 0;
            if (R81.Checked == true)
            {
                r8 = 5;
            }
            if (R82.Checked == true)
            {
                r8 = 4;
            }
            else if (R83.Checked == true)
            {
                r8 = 1;
            }

            int r9 = 0;
            if (R91.Checked == true)
            {
                r9 = 5;
            }
            if (R92.Checked == true)
            {
                r9 = 4;
            }
            else if (R93.Checked == true)
            {
                r9 = 1;
            }

            int r10 = 0;
            if (R101.Checked == true)
            {
                r10 = 5;
            }
            if (R102.Checked == true)
            {
                r10 = 4;
            }
            else if (R103.Checked == true)
            {
                r10 = 1;
            }

            int r11 = 0;
            if (R111.Checked == true)
            {
                r11 = 5;
            }
            if (R112.Checked == true)
            {
                r11 = 4;
            }
            else if (R113.Checked == true)
            {
                r11 = 1;
            }

            int r12 = 0;
            if (R121.Checked == true)
            {
                r12 = 5;
            }
            if (R122.Checked == true)
            {
                r12 = 4;
            }
            else if (R123.Checked == true)
            {
                r12 = 1;
            }
            int r13 = 0;
            if (R131.Checked == true)
            {
                r13 = 5;
            }
            if (R132.Checked == true)
            {
                r13 = 4;
            }
            else if (R133.Checked == true)
            {
                r13 = 1;
            }
            int r14 = 0;
            if (R141.Checked == true)
            {
                r14 = 5;
            }
            if (R142.Checked == true)
            {
                r14 = 4;
            }
            else if (R143.Checked == true)
            {
                r14 = 1;
            }
            int r15 = 0;
            if (R151.Checked == true)
            {
                r15 = 5;
            }
            if (R152.Checked == true)
            {
                r15 = 4;
            }
            else if (R153.Checked == true)
            {
                r15 = 1;
            }
            int r16 = 0;
            if (R161.Checked == true)
            {
                r16 = 5;
            }
            if (R162.Checked == true)
            {
                r16 = 4;
            }
            else if (R163.Checked == true)
            {
                r16 = 1;
            }
            int r17 = 0;
            if (R171.Checked == true)
            {
                r17 = 5;
            }
            if (R172.Checked == true)
            {
                r17 = 4;
            }
            else if (R173.Checked == true)
            {
                r17 = 1;
            }
            int r18 = 0;
            if (R181.Checked == true)
            {
                r18 = 5;
            }
            if (R182.Checked == true)
            {
                r18 = 4;
            }
            else if (R183.Checked == true)
            {
                r18 = 1;
            }
            int r19 = 0;
            if (R191.Checked == true)
            {
                r19 = 5;
            }
            if (R192.Checked == true)
            {
                r19 = 4;
            }
            else if (R193.Checked == true)
            {
                r19 = 1;
            }
            int r20 = 0;
            if (R201.Checked == true)
            {
                r20 = 5;
            }
            if (R202.Checked == true)
            {
                r20 = 4;
            }
            else if (R203.Checked == true)
            {
                r20 = 1;
            }

            // string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SQLConnString"].ToString();

            //  SqlConnection connection = new SqlConnection(connectionString);
            int total = 0;
            total = r1 + r2 + r3 + r4 + r5 + r6 + r7 + r8 + r9 + r10 + r11 + r12 + r13 + r14 + r15 + r16 + r17 + r18 + r19 + r20;
            String SQLString = "insert into HLX_MYDHS values('" + loginUser.UserId + "','" + loginUser.UserName + "','" + loginUser.DeptId + "','" + sex + "','" + year + "'," + total + ",'" + TextBox2.Text + "',getdate()," + r1;
            SQLString = SQLString + "," + r2;
            SQLString = SQLString + "," + r3;
            SQLString = SQLString + "," + r4;
            SQLString = SQLString + "," + r5;
            SQLString = SQLString + "," + r6;
            SQLString = SQLString + "," + r7;
            SQLString = SQLString + "," + r8;
            SQLString = SQLString + "," + r9;
            SQLString = SQLString + "," + r10;
            SQLString = SQLString + "," + r11;
            SQLString = SQLString + "," + r12;
            SQLString = SQLString + "," + r13;
            SQLString = SQLString + "," + r14;
            SQLString = SQLString + "," + r15;
            SQLString = SQLString + "," + r16;
            SQLString = SQLString + "," + r17;
            SQLString = SQLString + "," + r18;
            SQLString = SQLString + "," + r19;
            SQLString = SQLString + "," + r20 + ")";
            SqlDataSource1.InsertCommand = SQLString;
            SqlDataSource1.Insert();

            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r1 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='一'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r2 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='二'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r3 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='三'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r4 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='四'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r5 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='五'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r6 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='六'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r7 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='七'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r8 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='八'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r9 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='九'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r10 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r11 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十一'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r12 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十二'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r13 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十三'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r14 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十四'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r15 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十五'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r16 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十六'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r17 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十七'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r18 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十八'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();

            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r19 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='十九'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();
            //SQLString = "update HLX_MYDZH set VALUE=VALUE+" + r20 + " where yh='h' and 科室='" + loginUser.DeptId + "' and SUBJECT='二十'";

            //SqlDataSource1.UpdateCommand = SQLString;
            //SqlDataSource1.Update();

            //   SqlCommand cmd = new SqlCommand(SQLString, connection);

            //   int rows = cmd.ExecuteNonQuery();
            Response.Redirect("ok.htm", true);
        }


    }
}