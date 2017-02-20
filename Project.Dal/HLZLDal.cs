using System;
using System.Text;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using Project.Model;
using Project.Common;

namespace Project.Dal
{///Title: HLZLDal类
    ///Description: 护理质量上报数据操作类
    ///
    ///@version 1.0.0.0
    ///
    ///@modify 
    ///@date 
    /// </summary>
    public class HLZLDal
    {

        /// <summary>
        /// 在dbo.HLZL中新增一条记录,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Insert(HLZL model, SqlTransaction trans)
        {
            const string sql = "INSERT INTO dbo.HLX_HLAQ_HLZL(report_date,report_dept,bb_zrhs,yb_zrhs,bb_szhz,yb_szhz,zg_work_time,wcg_days,zy_stys,yc_gwhz,zc_ddhz,report_season,report_year) VALUES(@report_date,@report_dept,@bb_zrhs,@yb_zrhs,@bb_szhz,@yb_szhz,@zg_work_time,@wcg_days,@zy_stys,@yc_gwhz,@zc_ddhz,@report_season,@report_year)";

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
        /// 删除一条记录的方法
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Delete(int id, SqlTransaction trans)
        {
            const string sql = "delete dbo.HLX_HLAQ_HLZL where id=@id";
            SqlParameter[] parms = {
                                        new SqlParameter("@id",SqlDbType.Int),
                                    };
            parms[0].Value = id;
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

        public int CheckExist(HLZL model, SqlTransaction trans)
        {
            const string sql = "select count(*) from dbo.HLX_HLAQ_HLZL where report_year=@report_year and  report_season=@report_season and report_dept=@report_dept";
            SqlParameter[] parms = GetParms(model);
            int n = 0;
            try
            {
                if (trans == null)
                    n = Convert.ToInt32(SQLHelper.ExecuteScalar(SQLHelper.ConnectionString, CommandType.Text, sql, parms));
                else
                    n = Convert.ToInt32(SQLHelper.ExecuteNonQuery(trans, CommandType.Text, sql, parms));
            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }
            return n;

        }

       
     

        /// <summary>
        /// 按片区查某年某季度某科室的上报信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DataSet QueryInfo(string year, int season, string dept, string area)
        {
            const string ifDept = "select * from HLX_HLAQ_HLZL  where report_year=@report_year and report_season=@report_season and report_dept=@report_dept";
            const string ifArea = "select * from HLX_HLAQ_HLZL a ,Department b where a.report_dept=b.Deptid and  report_year=@report_year and report_season=@report_season and b.DeptPQ=@AreaID";
            //const string ifGlobal = "select sum(bb_zrhs)as bb_zrhs,sum(yb_zrhs) as yb_zrhs,sum(bb_szhz) as bb_szhz,sum(yb_szhz) as yb_szhz,sum(zg_work_time) as zg_work_time,sum(wcg_days) as wcg_days,sum(zy_stys) as zy_stys,sum(yc_gwhz)as yc_gwhz,sum(zc_ddhz) as zc_ddhz from HLX_HLAQ_HLZL where report_year=@report_year and report_season=@report_season";
            const string ifGlobal = "select * from HLX_HLAQ_HLZL where report_year=@report_year and report_season=@report_season ";
            SqlParameter[] parms = {
                                        new SqlParameter("@report_year",SqlDbType.NChar,4),
                                        new SqlParameter("@report_season",SqlDbType.Int),
										new SqlParameter("@report_dept",SqlDbType.VarChar,3),
                                        new SqlParameter("@AreaID",SqlDbType.NVarChar,7)
                                    };
            parms[0].Value = year;
            parms[1].Value = season;
            if (dept == "" && dept == null)
            {
                parms[2].Value = "";
            }
            else
            {
                parms[2].Value = dept;
            }
            parms[3].Value = area;
            if (dept != "" && dept != null)
            {
                DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifDept, parms);
                return dt;
            }
            else if (!string.IsNullOrEmpty(area))
            {
                DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifArea, parms);
                return dt;
            }
            else
            {
                DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifGlobal, parms);
                return dt;
            }
        }
        /// <summary>
        /// Year_DropDownList绑定年份
        /// </summary>
        /// <returns></returns>
        public DataSet BindYear()
        {
            const string sql = "select distinct YEAR(report_date) as year from HLX_HLAQ_HLZL";
            DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, sql, null);
            return dt;
        }

        /// <summary>
        /// 参数
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private SqlParameter[] GetParms(HLZL model)
        {
            SqlParameter[] parms = {
                new SqlParameter("@id", SqlDbType.Int),	
				new SqlParameter("@report_date", SqlDbType.VarChar,25),			
				new SqlParameter("@report_dept", SqlDbType.VarChar,3),			
				new SqlParameter("@bb_zrhs", SqlDbType.Decimal),			
				new SqlParameter("@yb_zrhs", SqlDbType.Decimal),
			    new SqlParameter("@bb_szhz",SqlDbType.Decimal),
				new SqlParameter("@yb_szhz", SqlDbType.Decimal),			
				new SqlParameter("@zg_work_time", SqlDbType.Decimal),
			    new SqlParameter("@wcg_days", SqlDbType.Decimal),			
				new SqlParameter("@zy_stys", SqlDbType.Decimal),			
				new SqlParameter("@yc_gwhz", SqlDbType.Decimal),			
				new SqlParameter("@zc_ddhz", SqlDbType.Decimal),
			    new SqlParameter("@report_year",SqlDbType.NChar),
				new SqlParameter("@report_season", SqlDbType.Int)
				};
            parms[0].Value = model.id;
            parms[1].Value = model.report_date;
            parms[2].Value = model.report_dept;
            parms[3].Value = model.bb_zrhs;
            parms[4].Value = model.yb_zrhs;
            parms[5].Value = model.bb_szhz;
            parms[6].Value = model.yb_szhz;
            parms[7].Value = model.zg_work_time;
            parms[8].Value = model.wcg_days;
            parms[9].Value = model.zy_stys;
            parms[10].Value = model.yc_gwhz;
            parms[11].Value = model.zc_ddhz;
            parms[12].Value = model.report_year;
            parms[13].Value = model.report_season;
            return parms;
        }
    }



}
