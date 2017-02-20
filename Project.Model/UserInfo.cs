﻿

using System;

namespace Project.Model
{
	///========================================================================
	/// Project: 权限项目	
   	///========================================================================
	/// <summary>
	///Title: UserInfo类
	///Description: dbo.UserInfo数据表实体模型代码
	///
	///@version 1.0.0.0
	///
	///@modify 
	///@date 
	/// </summary>
	public class UserInfo
	{	
		private string  _userId;
		private string _userName = String.Empty;
		private string _userPwd = String.Empty;
		private string _roleId;
        private string _deptId;
		private string _desc = String.Empty;
		private int _isLock;
		
		/// <summary>
		/// 主键
		/// </summary>
		public string UserId
		{
			get { return _userId; }
			set { _userId = value; }
		}

		/// <summary>
		/// 管理员名称
		/// </summary>
		public string UserName
		{
			get { return _userName; }
			set { _userName = value; }
		}

		/// <summary>
		/// 管理员密码
		/// </summary>
		public string UserPwd
		{
			get { return _userPwd; }
			set { _userPwd = value; }
		}

		/// <summary>
		/// 角色Id
		/// </summary>
        public string RoleId
		{
			get { return _roleId; }
			set { _roleId = value; }
		}
        /// <summary>
        /// 角色所在科室
        /// </summary>
        public string DeptId
        {
            get { return _deptId; }
            set { _deptId = value; }
        }

		/// <summary>
		/// 备注
		/// </summary>
		public string Desc
		{
			get { return _desc; }
			set { _desc = value; }
		}

		/// <summary>
		/// 是否锁定(0否1是)
		/// </summary>
		public int IsLock
		{
			get { return _isLock; }
			set { _isLock = value; }
		}

	}
}
