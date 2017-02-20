﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Project.Bll;
using Project.Model;
using Project.Common;
using System.Collections.Generic;
using Project.WebUi.App_Code;

namespace Project.WebUi.SystemManage
{
    public partial class UserEdit : MyBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                BindDept();
                BindRole();
                ShowData();
            }
             
            
        }


        protected void ShowData()
        {
            string id = Request["UserId"];
            if (!string.IsNullOrEmpty(id))
            {
                this.txtUserCode.ReadOnly = true;
                this.trPwd.Visible = false;
                UserInfoBll bll = new UserInfoBll();
                UserInfo model = bll.GetModel(id);
                if (model != null)
                {
                    this.txtUserName.Text = model.UserName;
                    this.txtUserCode.Text = model.UserId;
                    this.userDept.SelectedValue = model.DeptId;
                    string[] roleIds = model.RoleId.Split(',');
                    for (int i = 0; i < this.chkListRole.Items.Count; i++)
                    {
                        for (int j = 0; j < roleIds.Length; j++)
                        {
                            if (chkListRole.Items[i].Value == roleIds[j])
                                chkListRole.Items[i].Selected = true;
                        }
                    }
                    this.rdoList.SelectedValue = model.IsLock.ToString();
                    this.txtDesc.Text = model.Desc;
                }
            }
            else
            {
                btnRestPwd.Visible = false;
            }
        }

        //绑定科室的下拉菜单，还没写完科室的model，所以这部分还没写
        protected void BindDept()
        {
            DepartmentBll deptBll = new DepartmentBll();
            List<Department> list = deptBll.getTopList();
            if (list != null)
            { 
                this.userDept.DataSource = list;
                this.userDept.DataTextField = "DeptName";
                this.userDept.DataValueField = "DeptId";
                this.userDept.DataBind();
                this.userDept.Items.Insert(0, new ListItem("请选择科室", "0"));
            }
      
        }
        



        //绑定角色下拉列表
        protected void BindRole()
        {
            UserRoleBll bll = new UserRoleBll();
            List<UserRole> list = bll.GetList();
            if (list != null)
            {
                this.chkListRole.DataSource = list;
                this.chkListRole.DataTextField = "RoleName";
                this.chkListRole.DataValueField = "RoleId";
                this.chkListRole.DataBind();
            }
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string id = Request["UserId"];
            UserInfoBll bll = new UserInfoBll();
            UserInfo model = new UserInfo();
            string oldAdminName = string.Empty;
            if (!string.IsNullOrEmpty(id))//如果是修改操作
            {
                
                model = bll.GetModel(id);
            }
            else //如果是新增操作
            {
                model.UserPwd = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(this.txtUserPwd.Text.Trim(), "MD5");
            }
            model.UserName = this.txtUserName.Text.Trim();
            model.UserId = this.txtUserCode.Text.Trim();
            model.RoleId = "";
            model.DeptId = "";
            for (int i = 0; i < this.chkListRole.Items.Count; i++)
            {
                if(this.chkListRole.Items[i].Selected)
                {
                    model.RoleId += this.chkListRole.Items[i].Value + ",";
                }
            }
            if (model.RoleId.IndexOf(',') != -1)
            {
                model.RoleId = model.RoleId.Substring(0, model.RoleId.Length - 1);
            }
            if (string.IsNullOrEmpty(model.UserId))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请输入用户编码！');</script>");
                return;
            }
            if (string.IsNullOrEmpty(model.UserName))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请输入用户名！');</script>");
                return;
            }
            if (string.IsNullOrEmpty(model.RoleId))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请选择一个角色！');</script>");
                return;
            }
            if(userDept.SelectedIndex==0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('请选择科室！');</script>");
                return;
            }
             
            model.DeptId = userDept.SelectedValue;
            model.IsLock = Convert.ToInt32(this.rdoList.SelectedValue);
            model.Desc = this.txtDesc.Text.Trim();


            int n = 0;
            if (!string.IsNullOrEmpty(id))//如果是修改操作
            {
                n = bll.Update(model, null);
            }
            else //如果是新增操作
            {
                n = bll.Insert(model, null);
            }

            if (n > 0)
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存成功！'); </script>");

            else
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('保存失败！');</script>");
        }
        /// <summary>
        /// 初始化密码
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRestPwd_Click(object sender, EventArgs e)
        {
            string id = Request["UserId"];
            UserInfoBll bll = new UserInfoBll();
            UserInfo model = new UserInfo();
            model.UserId = id;
            model.UserPwd = CommonFun.GetMD5("aaaaaa");
            int n = 0;
            n = bll.UpdatePwd(model, null);
            if (n > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('密码初始化成功！');</script>");
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('修改失败！');</script>");
            }
        }
    }
}
