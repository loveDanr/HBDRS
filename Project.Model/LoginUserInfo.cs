using System;

namespace Project.Model
{
    [Serializable]
    public class LoginUserInfo
    {
        private string userId;
        
        /// <summary>
        /// 用户编号
        /// </summary>
        public string UserId
        {
            get { return userId; }
            set { userId = value; }
        }
        private string userName;
        /// <summary>
        /// 用户名称
        /// </summary>
        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }

        private string userPwd;
        /// <summary>
        /// 用户密码
        /// </summary>
        public string UserPwd
        {
            get { return userPwd; }
            set { userPwd = value; }
        }
        private string roleId;
        /// <summary>
        /// 角色编号
        /// </summary>
        public string RoleId
        {
            get { return roleId; }
            set { roleId = value; }
        }
        private string deptId;
        /// <summary>
        /// 部门编号
        /// </summary>
        public string DeptId
        {
            get { return deptId; }
            set { deptId = value; }
        }


    }
}
