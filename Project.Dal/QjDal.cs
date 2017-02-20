using System;
using System.Text;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using Project.Model;
using Project.Common;

namespace Project.Dal
{
   public  class QjDal
   {

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
           DataTable dt = null;
           int startIndex = pageIndex <= 1 ? 1 : ((pageIndex - 1) * pageSize + 1);
           int endIndex = startIndex + pageSize - 1;
           SqlParameter[] parms = { 
                                       new SqlParameter("@StartIndex",SqlDbType.Int),
                                       new SqlParameter("@EndIndex",SqlDbType.Int),
                                       new SqlParameter("@WhereSql",SqlDbType.NVarChar,2000),
                                       new SqlParameter("@RecordCount",SqlDbType.Int)
                                   };
           parms[0].Value = startIndex;
           parms[1].Value = endIndex;
           parms[2].Value = whereSql;
           parms[3].Direction = ParameterDirection.Output;
           dt = SQLHelper.GetDataTable(CommandType.StoredProcedure, "UP_QJ_leave_List_select", parms);
           recordCount = Convert.ToInt32(parms[3].Value);
           return dt;
       }

       /// <summary>
       /// 在dbo.QJ_leave中新增一条记录,支持数据库事务
       /// </summary>
       /// <param name="model">包含被插入数据的实体对象</param>
       /// <param name="trans">事务参数</param>
       /// <returns>影响行数</returns>
       public int Insert(QJ model, SqlTransaction trans)
       {
           const string sql = "INSERT INTO [dbo].[QJ_leave]([UserId],[QjDate],[QjDays],[Reason],[ApproverId])VALUES(@UserID,@QjDate,@QjDays,@Reason,@ApproverId)";

           SqlParameter[] parms = GetParms(model);

           int n = 0;
           try
           {
               if (trans == null)
                   n = SQLHelper.ExecuteNonQuery(SQLHelper.ConnectionString, CommandType.Text, sql, parms);
               else
                   n = SQLHelper.ExecuteNonQuery(trans, CommandType.Text, sql, parms);
           }
           catch (Exception ex)
           {
               Common.LogHelper.WriteLog(this.GetType(), ex);
           }
           return n;
       }
       /// <summary>
       /// 更新QJ_Personal表的相应数据
       /// </summary>
       /// <param name="days"></param>
       /// <param name="userid"></param>
       /// <returns></returns>
       public int updatePersonal(int days,string userid)
       {
           const string sql = "exec updateTotalDays @QjDays,@UserId";
           SqlParameter[] parms = {
                                        new SqlParameter("@QjDays",SqlDbType.Int),
                                        new SqlParameter("@UserId",SqlDbType.VarChar,6)
                                    };
           parms[0].Value = days;
           parms[1].Value = userid;

           int n = 0;
           try
           {
                   n = SQLHelper.ExecuteNonQuery(SQLHelper.ConnectionString, CommandType.Text, sql, parms);
           }
           catch (Exception ex)
           {
               Common.LogHelper.WriteLog(this.GetType(), ex);
           }
           return n;

       }

       /// <summary>
       /// 根据用户id查询请假信息
       /// </summary>
       /// <param name="model"></param>
       /// <returns></returns>
       public DataSet QueryInfo(string userId)
       {
           const string getThisInfo = "select a.UserId,username,QjDate,QjDays,Reason,ApproverId from QJ_leave a,UserInfo b where a.UserId=b.UserId and a.UserId=@UserId order by a.QjDate desc";
           SqlParameter[] parms = {
                                        new SqlParameter("@UserId",SqlDbType.VarChar,6),
                                    };
           parms[0].Value = userId;
         
               DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
               return dt;
       }
       /// <summary>
       /// 根据用户名查询请假信息
       /// </summary>
       /// <param name="userName"></param>
       /// <param name="deptId"></param>
       /// <returns></returns>
       public DataSet QueryInfoByName(string userName, string deptId)
       {
           const string getThisInfo = "select a.UserId,username,QjDate,QjDays,Reason,ApproverId from QJ_leave a,UserInfo b where a.UserId=b.UserId and b.DeptId=@deptId and b.UserName like '%'+@UserName+'%' order by a.QjDate desc";
           SqlParameter[] parms = {
                                        new SqlParameter("@UserName",SqlDbType.VarChar,50),
                                        new SqlParameter("@deptId",SqlDbType.VarChar,3)
                                    };
           parms[0].Value = userName;
           parms[1].Value = deptId;

           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
           return dt;
 
       }

       /// <summary>
       /// 根据用户名和用户id查询请假信息
       /// </summary>
       /// <param name="userName"></param>
       /// <param name="deptId"></param>
       /// <returns></returns>
       public DataSet QueryInfoByNameAndId(string userName, string Id,string deptId)
       {
           const string getThisInfo = "select a.UserId,username,QjDate,QjDays,Reason,ApproverId from QJ_leave a,UserInfo b where a.UserId=b.UserId and b.DeptId=@deptId and a.UserId=@UserId and b.UserName like '%'+@UserName+'%' order by a.QjDate desc";
           SqlParameter[] parms = {
                                        new SqlParameter("@UserName",SqlDbType.VarChar,50),
                                        new SqlParameter("@deptId",SqlDbType.VarChar,3),
                                        new SqlParameter("@UserId",SqlDbType.VarChar,6),
                                    };
           parms[0].Value = userName;
           parms[1].Value = deptId;
           parms[2].Value = Id;

           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
           return dt;

       }
       /// <summary>
       /// 获取科室请假信息
       /// </summary>
       /// <param name="deptId"></param>
       /// <returns></returns>
       public DataSet QueryDeptInfo(string deptId)
       {
           const string getDeptInfo = "select a.UserId,username,QjDate,QjDays,Reason,ApproverId from QJ_leave a,UserInfo b where a.UserId=b.UserId and b.DeptId=@deptId order by a.QjDate desc";
           SqlParameter[] parms = {
                                        new SqlParameter("@deptId",SqlDbType.VarChar,3)
                                    };
           parms[0].Value = deptId;
           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getDeptInfo, parms);
           return dt;
       }
       /// <summary>
       /// 装载dbo.QJ_leavePage实体
       /// </summary>
       /// <param name="dr">记录集</param>
       /// <returns>返回对象</returns>
       private QJ LoadModel(IDataReader dr)
       {
           QJ model = new QJ();
           model.UserID = dr["UserId"].ToString();
           model.QjDate = dr["QjDate"].ToString();
           model.QjDays =Convert.ToInt32(dr["QjDays"].ToString());
           model.Reason = dr["Reason"].ToString();
           model.ApproverId = dr["ApproverId"].ToString();
           return model;
       }
       /// <summary>
       /// 参数
       /// </summary>
       /// <param name="model"></param>
       /// <returns></returns>
       private SqlParameter[] GetParms(QJ model)
       {
           SqlParameter[] parms = {
                new SqlParameter("@UserID", SqlDbType.VarChar,6),	
				new SqlParameter("@QjDate", SqlDbType.VarChar,25),			
				new SqlParameter("@QjDays", SqlDbType.Int),			
				new SqlParameter("@Reason", SqlDbType.VarChar,1000),			
				new SqlParameter("@ApproverId", SqlDbType.VarChar,6),
				};
           parms[0].Value = model.UserID;
           parms[1].Value = model.QjDate;
           parms[2].Value = model.QjDays;
           parms[3].Value = model.Reason;
           parms[4].Value = model.ApproverId;
           return parms;
       }

    }
}
