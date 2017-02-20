using System;
using System.Collections.Generic;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;
using System.Data;

namespace Project.Bll
{
    public class QJ_TotalBll
    {
        private readonly QJ_TotalDal dal = new QJ_TotalDal();

        /// <summary>
        /// 修改一条请假记录的方法
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Update(string userid,int totaldays,int restdays)
        {
            return dal.Update(userid,totaldays,restdays);
        }
        /// <summary>
        /// 获取科室信息
        /// </summary>
        /// <param name="deptid"></param>
        /// <returns></returns>
        public DataSet GetDeptInfo(string deptid)
        {
            return dal.QueryDeptInfo(deptid);
        }
        /// <summary>
        /// 根据用户名获取某个用户的信息
        /// </summary>
        /// <param name="userid"></param>
        /// <param name="deptid"></param>
        /// <returns></returns>
        public DataSet QueryStaffInfo(string username, string deptid)
        {
            return dal.QueryStaffInfo(username,deptid);
        }
        /// <summary>
        /// 根据Userid查询自己的假期记录
        /// </summary>
        /// <param name="userid"></param>
        /// <param name="deptid"></param>
        /// <returns></returns>
        public DataSet QueryStaffInfoByID(string userid, string deptid)
        {
            return dal.QueryStaffInfoByID(userid,deptid);
        }

        /// <summary>
        /// 根据主键获取dbo.QJ_Total中的一条记录
        /// </summary>
        /// <param name="id">主键id</param>
        /// <returns>实体模型</returns>
        public QJ_Total GetModel(string id)
        {
            return dal.GetModel(id);
        }

    }
}
