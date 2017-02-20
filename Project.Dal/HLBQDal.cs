using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using Project.Model;
using Project.Common;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;


namespace Project.Dal
{
    public class HLBQDal
    {
        ///// <summary>
        ///// GridView绑定，默认加载所有片区数据
        ///// </summary>
        ///// <returns></returns>
        //public DataSet GetTopList()
        //{
        //    const string sql = "SELECT * FROM [HLX_Area]";
        //    DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, sql, null);
        //    return dt;
        //}
        /// <summary>
        /// 读取所有片区
        /// </summary>
        /// <returns></returns>
        public DataTable GetallHLX_Area()
        {
            const string sql = "select * from HLX_Area";
            return SQLHelper.GetDataTable(CommandType.Text, sql, null);
        }
        /// <summary>
        /// 在dbo.护理片区中新增一条片区,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Insert(HLX_Area model, SqlTransaction trans)
        {
            const string sql = "INSERT INTO HLX_Area(AreaName, AreaManager) VALUES (@AreaName, @AreaManager)";

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
        /// 在dbo.护理片区中修改片区,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Update(HLX_Area model, SqlTransaction trans)
        {
            const string sql = "UPDATE HLX_Area SET AreaName =@AreaName,AreaManager = @AreaManager WHERE AreaID=@AreaID";

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
        /// 在dbo.护理片区中删除片区,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Delete(HLX_Area model, SqlTransaction trans)
        {


            const string sql = "DELETE FROM HLX_Area WHERE (AreaID = @AreaID);update Department SET DeptPQ = ''  where DeptPQ=@AreaID";

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
        /// 用list获取片区
        /// </summary>
        /// <returns>list集合</returns>
        public List<HLX_Area> GetHLX_Area()
        {
            List<HLX_Area> list = new List<HLX_Area>();

            string sql = "select * from HLX_Area";
            using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, null))
            {
                while (dr.Read())
                {
                    HLX_Area hlx = new HLX_Area();
                    hlx.AreaID = dr[0].ToString();
                    hlx.AreaName = dr[1].ToString();
                    list.Add(hlx);

                }
            }
            return list;
        }

        /// <summary>
        /// 获取已归属片区的科室
        /// </summary>
        /// <param name="areaID"></param>
        /// <returns></returns>
        public DataTable GetDeptInArea(string areaID)
        {
            DataTable dt = new DataTable();
            const string sql = "select a.DeptID,DeptName from Department a, HLX_Area b where a.deptPQ = b.AreaID and b.AreaID=@AreaID";
            SqlParameter[] parms = {						
							new SqlParameter("@AreaID",SqlDbType.NVarChar,7)
		    };
            parms[0].Value = areaID;
            try
            {
                dt = SQLHelper.GetDataTable(CommandType.Text,sql,parms);
             
            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }

            return dt;
        }
        /// <summary>
        /// 获取未归属片区的科室
        /// </summary>
        /// <param name="areaID"></param>
        /// <returns></returns>
        public DataTable GetDeptNotInArea()
        {
            DataTable dt = new DataTable();
            const string sql = "select deptID,DeptName from Department where ParentDeptID <> -1 AND deptpq=''";
            try
            {
                dt = SQLHelper.GetDataTable(CommandType.Text, sql, null);

            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }

            return dt;
        }
        /// <summary>
        /// 参数
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private SqlParameter[] GetParms(HLX_Area model)
        {
            SqlParameter[] parms = {
                new SqlParameter("@AreaID", SqlDbType.NVarChar,7),	
				new SqlParameter("@AreaName", SqlDbType.NVarChar,50),			
				new SqlParameter("@AreaManager", SqlDbType.NVarChar,6),			
				};
            parms[0].Value = model.AreaID == null ? string.Empty : model.AreaID; ;
            parms[1].Value = model.AreaName == null ? string.Empty : model.AreaName; ;
            parms[2].Value = model.AreaManager == null ? string.Empty : model.AreaManager; 
            return parms;
        }
    }
}
