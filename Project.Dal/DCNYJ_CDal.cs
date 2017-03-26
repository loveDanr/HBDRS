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
    ///Title: DCNYJ临床科室上报DAL类
    ///
    ///@version 1.0.0.0
    ///
    ///@modify 
    ///@date 
    /// </summary>
    class DCNYJ_CDal
    {
        /// <summary>
        /// 在DCNYJ_Clinical中新增一条记录,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Insert(DCNYJ model, SqlTransaction trans)
        {
            const string sql = @"INSERT INTO [dbo].[DCNYJ_Clinical]([report_date]
           ,[report_dept]
           ,[hzjcls]
           ,[yxzxls]
           ,[wgl]
           ,[xdj]
           ,[sws]
           ,[wjcz]
           ,[tzq]
           ,[xdbdw]
           ,[ylfw]
           ,[fhcs]
           ,[bzx]
           ,[other])
     VALUES
           (@report_date
           ,@report_dept
           ,@hzjcls
           ,@yxzxls
           ,@wgl
           ,@xdj
           ,@sws
           ,@wjcz
           ,@tzq
           ,@xdbdw
           ,@ylfw
           ,@fhcs
           ,@bzx
           ,@other)";
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
            const string sql = "delete dbo.DCNYJ_Clinical where id=@id";
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
        /// <summary>
        /// 查看是否已经存在记录
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int CheckExist(DCNYJ model, SqlTransaction trans)
        {
            const string sql = "select count(*) from HLX_HLAQ_HLZL where report_dept=@report_dept and convert(varchar(7),report_date,120)=convert(varchar(7),@report_date,120)";
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
        public DataSet QueryInfo(string startDate, string endDate, string dept, string area)
        {
            const string ifDept = "select * from DCNYJ_Clinical  where report_year=@report_year and report_season=@report_season and report_dept=@report_dept";
            const string ifArea = "select * from DCNYJ_Clinical a ,Department b where a.report_dept=b.Deptid and  report_year=@report_year and report_season=@report_season and b.DeptPQ=@AreaID";
            //const string ifGlobal = "select sum(bb_zrhs)as bb_zrhs,sum(yb_zrhs) as yb_zrhs,sum(bb_szhz) as bb_szhz,sum(yb_szhz) as yb_szhz,sum(zg_work_time) as zg_work_time,sum(wcg_days) as wcg_days,sum(zy_stys) as zy_stys,sum(yc_gwhz)as yc_gwhz,sum(zc_ddhz) as zc_ddhz from HLX_HLAQ_HLZL where report_year=@report_year and report_season=@report_season";
            const string ifGlobal = "select * from HLX_HLAQ_HLZL where report_year=@report_year and report_season=@report_season ";
            SqlParameter[] parms = {
                                        new SqlParameter("@startDate",SqlDbType.VarChar,25),
                                        new SqlParameter("@endDate",SqlDbType.VarChar,25),
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
        /// 参数
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private SqlParameter[] GetParms(DCNYJ model)
        {
            SqlParameter[] parms = {
                new SqlParameter("@id", SqlDbType.Int),	
				new SqlParameter("@report_date", SqlDbType.VarChar,25),			
				new SqlParameter("@report_dept", SqlDbType.VarChar,3),			
				new SqlParameter("@hzjcls", SqlDbType.Int),			
				new SqlParameter("@yxzxls", SqlDbType.Int),
			    new SqlParameter("@wgl",SqlDbType.Int),
				new SqlParameter("@xdj", SqlDbType.Int),			
				new SqlParameter("@sws", SqlDbType.Int),
			    new SqlParameter("@wjcz", SqlDbType.Int),			
				new SqlParameter("@tzq", SqlDbType.Int),			
				new SqlParameter("@xdbdw", SqlDbType.Int),			
				new SqlParameter("@ylfw", SqlDbType.Int),
			    new SqlParameter("@fhcs",SqlDbType.Int),
				new SqlParameter("@bzx", SqlDbType.Int),
                new SqlParameter("@other", SqlDbType.Int),
				};
            parms[0].Value = model.Id;
            parms[1].Value = model.Report_date;
            parms[2].Value = model.Report_dept;
            parms[3].Value = model.Hzzjcls;
            parms[4].Value = model.Yxzxls;
            parms[5].Value = model.Wgl;
            parms[6].Value = model.Xdj;
            parms[7].Value = model.Sws;
            parms[8].Value = model.Wjcz;
            parms[9].Value = model.Tzq;
            parms[10].Value = model.Xdbdw;
            parms[11].Value = model.Ylfw;
            parms[12].Value = model.Fhcs;
            parms[13].Value = model.Bzx;
            parms[14].Value = model.Other;
            return parms;
        }


    }
}
