using System;
using System.Collections.Generic;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;
using System.Data;

namespace Project.Bll
{
    
    ///Title: QJBLL类
    ///Description: 请假操作业务逻辑操作类
    ///
    ///@version 1.0.0.0
    ///
    ///@modify 
    ///@date 
            public  class QjBll
            {
                private readonly QjDal dal = new QjDal();


                /// <summary>
                /// 根据条件分页查询信息
                /// </summary>
                /// <param name="pageIndex">当前页码</param>
                /// <param name="pageSize">每页大小</param>
                /// <param name="whereSql">分页查询条件</param>
                /// <param name="recordCount">out参数，当前条件下的总记录数</param>
                /// <returns>分页查询后的信息</returns>
                public DataTable GetList(int pageIndex, int pageSize, string whereSql, out int recordCount)
                {
                    return dal.GetList(pageIndex, pageSize, whereSql, out recordCount);
                }

                /// <summary>
                /// 插入一条请假记录的方法
                /// </summary>
                /// <param name="model"></param>
                /// <param name="trans"></param>
                /// <returns></returns>
                public int Insert(QJ model, SqlTransaction trans)
                {
                    return dal.Insert(model, trans);
                }
                /// <summary>
                /// 更新QJ_Personal相应内容
                /// </summary>
                /// <param name="days"></param>
                /// <param name="userid"></param>
                /// <returns></returns>
                public int updatePersonal(int days, string userid)
                {
                    return dal.updatePersonal(days,userid);
                }



                /// <summary>
                /// 根据条件查询某一个人的请假详情
                /// </summary>
                /// <param name="userid"></param>
                /// <returns></returns>
                public DataSet GetDetailsById(string userid)
                {
                    return dal.QueryInfo(userid);
                }
                /// <summary>
                /// 获取全科的请假信息
                /// </summary>
                /// <param name="deptId"></param>
                /// <returns></returns>
                public DataSet GetDeptQjInfo(string deptId)
                {
                    return dal.QueryDeptInfo(deptId);
                }
                /// <summary>
                /// 根据姓名查询请假信息
                /// </summary>
                /// <param name="userName"></param>
                /// <param name="deptId"></param>
                /// <returns></returns>
                public DataSet QueryInfoByName(string userName,string deptId)
                {
                    return dal.QueryInfoByName(userName,deptId);
                }
                /// <summary>
                /// 根据姓名和工号查询请假详细信息
                /// </summary>
                /// <param name="userName"></param>
                /// <param name="Id"></param>
                /// <param name="deptId"></param>
                /// <returns></returns>
                public DataSet QueryInfoByNameAndId(string userName, string Id,string deptId)
                {
                    return dal.QueryInfoByNameAndId(userName,Id,deptId); 
                }

              

            }
}
