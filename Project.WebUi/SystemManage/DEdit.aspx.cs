using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Project.Bll;
using Project.Dal;
using Project.Model;
using System.Reflection;
using System.Data.SqlClient;
using System.Data;


namespace Project.WebUi.SystemManage
{
    public partial class DEdit : System.Web.UI.Page
    {
        protected Department DMent = null;
        DepartmentBll Dbll = new DepartmentBll();
        HLBQBll bll = new HLBQBll();

        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                BindDept();
                showdata();
            }
            //SqlConnection conn = new SqlConnection("server=172.20.20.13;database=ProjectDB;uid=sa;pwd=11");
            //SqlCommand cmd = new SqlCommand("select * from department",conn);
            ////建立数据适配器、数据表并填充
            //SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            //DataTable dtable = new DataTable();
            //adpt.Fill(dtable);
            ////与表的数据绑定
            //txtBMBH.DataSource = dtable;//设置数据源
            //txtBMBH.DataTextField = "Text";//设置要读取数据表中的列名
            //txtBMBH.DataValueField = "Value";
            //txtBMBH.DataBind();//数据绑定



        }

        protected void showdata()
        {

            string deptid = Request["DeptId"];
            if (!string.IsNullOrEmpty(deptid))
            {
                this.txtKSBH.ReadOnly = true;
                DepartmentBll bll = new DepartmentBll();
                Department dept = bll.GetDepartment(deptid);
                this.txtKSBH.Text = dept.DeptID;
                this.txtBMBH.Text = dept.PartntDeptID;
                this.txtKSMC.Text = dept.DeptName;
                this.txtKSPYM.Text = dept.DeptPym;
                this.txtKSSX.Text = Convert.ToString(dept.DeptOrderNum);
                this.txtKSGS.Text = dept.DeptFunc;
            }

        }


        //protected void btnADD_Click(object sender, EventArgs e)
        //{
        //    Department dpt = new Department();
        //    dpt.DeptID = this.txtKSBH.Text.Trim();
        //    dpt.PartntDeptID = this.txtBMBH.Text.Trim();
        //    dpt.DeptName = this.txtKSMC.Text.Trim();
        //    dpt.DeptPym = this.txtKSPYM.Text.Trim();
        //    dpt.DeptOrderNum = Convert.ToInt32( this.txtKSSX.Text.Trim());
        //    dpt.DeptFunc = this.txtKSGS.Text.Trim();
        //    DepartmentBll bll = new DepartmentBll();
        //  int n=  bll.InsertDep(dpt ,null);
        //    if(n>0)
        //    {
        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存成功！');frameElement.lhgDG.curWin.location.reload();</script>");
        //    }
        //    else
        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');frameElement.lhgDG.curWin.location.reload();</script>");
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string id = Request["DeptID"] == null ? "" : Request["DeptID"].Trim();
            //string id = Request["DeptID"];

            Department dpt = new Department();
            if (!string.IsNullOrEmpty(id))//如果是修改操作
            {

                dpt.DeptID = id;
                dpt.PartntDeptID = this.txtBMBH.Text.Trim();
                dpt.DeptName = this.txtKSMC.Text.Trim();
                dpt.DeptPym = this.txtKSPYM.Text.Trim();
                dpt.DeptOrderNum = Convert.ToInt32(this.txtKSSX.Text.Trim());
                dpt.DeptFunc = this.txtKSGS.Text.Trim();
            }


            else //如果是新增操作
            {
                //string bh = null;
                ////string deptid = this.txtKSBH.Text.Trim();

                //bh = this.txtBMBH.SelectedValue.ToString();
                //if (bh == "中心医院")
                //{
                //    dpt.PartntDeptID = "0";
                //}
                //else if (bh == "防治科")
                //{
                //    dpt.PartntDeptID = "1";
                //}
                //else if (bh == "统计室")
                //{
                //    dpt.PartntDeptID = "2";
                //}
                //dpt.PartntDeptID = this.txtBMBH.Text.Trim();
                dpt.DeptID = this.txtKSBH.Text.Trim();
                dpt.PartntDeptID = this.txtBMBH.SelectedValue.ToString();
                dpt.DeptName = this.txtKSMC.Text.Trim();
                dpt.DeptPym = this.txtKSPYM.Text.Trim();
                dpt.DeptOrderNum = Convert.ToInt32(this.txtKSSX.Text.Trim());
                dpt.DeptPQ = this.txtGSPQ.SelectedValue.ToString();
                dpt.DeptFunc = this.txtKSGS.Text.Trim();
                int s;
                if (dpt != null)
                {
                    s = Dbll.CheckKSIDExist(dpt, null);
                    if (s > 0)
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('该部门编号已存在！');</script>");
                        return;
                    }
                }
            }
            int n = 0;
            if (!string.IsNullOrEmpty(id))//如果是修改操作
            {
                n = Dbll.UpdateDepartment(dpt, null);


            }
            else //如果是新增操作
            {
                n = Dbll.InsertDep(dpt, null);

            }

            if (n > 0)
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存成功！');frameElement.api.opener.location.reload(); </script>");//top.document.location.reload();
            else
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');</script>");
        }

        protected void btnFH_Click(object sender, EventArgs e)
        {

            Response.Write("<script>window.location.href='DList.aspx'</script>");



        }
        protected void BindDept()
        {
            DataTable hlx = bll.GetallHLX_Area();
            List<Department> list = Dbll.getTopList();
            if (list != null)
            {
                this.txtBMBH.DataSource = list;
                this.txtBMBH.DataValueField = "DeptId";
                this.txtBMBH.DataTextField = "DeptName";
                this.txtBMBH.DataBind();

            }
            if(hlx!=null)
            {
                this.txtGSPQ.DataSource = hlx;
                this.txtGSPQ.DataTextField = "AreaName";
                this.txtGSPQ.DataValueField = "AreaID";
                this.txtGSPQ.DataBind();
            }

        }



    }
}