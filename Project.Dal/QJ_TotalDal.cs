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
   public class QJ_TotalDal
    {
 
        /// <summary>
        /// 在dbo.QJ_Personal中修改一条数据,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Update(string userid,int totaldays,int restdays)
        {
            const string sql = "exec addDays @Userid,@TotalDays,@RestDays";
            SqlParameter[] parms = {						
							new SqlParameter("@UserId",SqlDbType.VarChar,6),
                            new SqlParameter("@TotalDays",SqlDbType.Int),
                            new SqlParameter("@RestDays",SqlDbType.Int),
		    };

            parms[0].Value = userid;
            parms[1].Value = totaldays;
            parms[2].Value = restdays;
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
       /// 根据用户id获取一个model
       /// </summary>
       /// <param name="id"></param>
       /// <returns></returns>
        public QJ_Total GetModel(string id)
        {
            const string sql = "SELECT * FROM QJ_Personal WHERE  UserId=@UserId ";
            SqlParameter[] parms = {						
							new SqlParameter("@UserId",SqlDbType.VarChar,6)
		    };

            parms[0].Value = id;
            QJ_Total model = null;

            using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, parms))
            {
                if (dr.Read())
                {
                    model = LoadModel(dr);
                }
            }
            return model;
        }

       /// <summary>
       /// 根据用户id装在QJ_Total实体
       /// </summary>
       /// <param name="dr"></param>
       /// <returns></returns>
        private QJ_Total LoadModel(IDataReader dr)
        {
            QJ_Total model = new QJ_Total();
            model.UserID = dr["UserId"].ToString();
            model.TotalDays =Convert.ToInt32(dr["TotalDays"].ToString());
            model.RestDays = Convert.ToInt32(dr["RestDays"].ToString());
            model.LastDays = Convert.ToInt32(dr["LastDays"].ToString());
            
            return model;
        }

       /// <summary>
       /// 当前科室所有人的假期情况显示
       /// </summary>
       /// <param name="deptId"></param>
       /// <returns></returns>
       public DataSet QueryDeptInfo(string deptId)
       {
           const string getThisInfo ="select a.userid,b.UserName,a.TotalDays,Restdays,LastDays from QJ_Personal a ,UserInfo b where a.UserId=b.UserId and b.DeptId=@DeptId";

           SqlParameter[] parms = {
                                        new SqlParameter("@DeptId",SqlDbType.VarChar,3)
                                    };
           parms[0].Value = deptId;
           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
           return dt;
       }
       /// <summary>
       /// 根据用户名查询
       /// </summary>
       /// <param name="userid"></param>
       /// <param name="deptid"></param>
       /// <returns></returns>
       public DataSet QueryStaffInfo(string UserName, string deptid)
       {
           const string getThisInfo = "select a.userid,b.UserName,a.TotalDays,Restdays,LastDays from QJ_Personal a ,UserInfo b where a.UserId=b.UserId and b.DeptId=@DeptId and b.UserName  like '%'+@UserName+'%'";
           SqlParameter[] parms = {
                                        new SqlParameter("@DeptId",SqlDbType.VarChar,3),
                                        new SqlParameter("@UserName",SqlDbType.VarChar,6),
                                    };
           parms[0].Value = deptid;
           parms[1].Value = UserName;
           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
           return dt;
       }

       /// <summary>
       /// 根据Userid查询自己的假期记录
       /// </summary>
       /// <param name="userid"></param>
       /// <param name="deptid"></param>
       /// <returns></returns>
       public DataSet QueryStaffInfoByID(string userid, string deptid)
       {
           const string getThisInfo = "select a.userid,b.UserName,a.TotalDays,Restdays,LastDays from QJ_Personal a ,UserInfo b where a.UserId=b.UserId and b.DeptId=@DeptId and a.UserId=@UserId";
           SqlParameter[] parms = {
                                        new SqlParameter("@DeptId",SqlDbType.VarChar,3),
                                        new SqlParameter("@UserId",SqlDbType.VarChar,6),
                                    };
           parms[0].Value = deptid;
           parms[1].Value = userid;
           DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, getThisInfo, parms);
           return dt;
       }
        /// <summary>
        /// 参数
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private SqlParameter[] GetParms(QJ_Total model)
        {
            SqlParameter[] parms = {
                new SqlParameter("@UserID", SqlDbType.VarChar,6),	
				new SqlParameter("@TotalDays", SqlDbType.Int),
                new SqlParameter("@RestDays", SqlDbType.Int),
                new SqlParameter("@LastDays", SqlDbType.Int)
				};
            parms[0].Value = model.UserID;
            parms[1].Value = model.TotalDays;
            parms[2].Value = model.RestDays;
            parms[3].Value = model.LastDays;
            return parms;
        }
    }
}
