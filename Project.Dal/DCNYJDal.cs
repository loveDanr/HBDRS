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
    public class DCNYJDal
    {
        /// <summary>
        /// 在DCNYJ_Clinical中新增一条记录,支持数据库事务
        /// </summary>
        /// <param name="model">包含被插入数据的实体对象</param>
        /// <param name="trans">事务参数</param>
        /// <returns>影响行数</returns>
        public int Insert(DCNYJ model, SqlTransaction trans)
        {
            const string sql = @"INSERT INTO [dbo].[DCNYJ]([report_date]
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
        /// 修改一条记录
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Update(DCNYJ model, string startdate, string enddate, SqlTransaction trans)
        {
            const string sql = @"update DCNYJ set hzjcls=@hzjcls,yxzxls=@yxzxls,wgl=@wgl,xdj=@xdj,sws=@sws,wjcz=@wjcz,tzq=@tzq,xdbdw=@xdbdw,ylfw=@ylfw,fhcs=@fhcs,bzx=@bzx,other=@other
 where convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate and report_dept=@report_dept";
            SqlParameter[] parms = GetParmsIncludeDatetime(model, startdate, enddate);
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
        /// 查看是否已经存在记录,存在了就弹出“本月已填报，不允许重复填报”
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int CheckExist(DCNYJ model, SqlTransaction trans)
        {
            const string sql = "select count(*) from DCNYJ where report_dept=@report_dept and datepart(mm,report_date)=datepart(mm,@report_date)";
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
        /// 其他的GridView显示返回Dataset
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="dept"></param>
        /// <param name="area"></param>
        /// <returns></returns>
        public DataSet QueryOther(string startDate, string endDate, string dept, string area)
        {
            const string ifDept = @"select id,report_dept,report_date,other from DCNYJ where report_dept=@report_dept and convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate order by report_date desc";
            const string ifArea = @"select id,report_dept,report_date,other from DCNYJ a ,Department b where a.report_dept=b.Deptid and convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate and b.DeptPQ=@AreaID order by report_date desc";
            const string ifGlobal = @"select id,report_dept,report_date,other from DCNYJ where convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate order by report_date desc";
            SqlParameter[] parms = {
                                        new SqlParameter("@startDate",SqlDbType.VarChar,25),
                                        new SqlParameter("@endDate",SqlDbType.VarChar,25),
										new SqlParameter("@report_dept",SqlDbType.VarChar,3),
                                        new SqlParameter("@AreaID",SqlDbType.NVarChar,7)
                                    };
            parms[0].Value = startDate;
            parms[1].Value = endDate;
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
                using (DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifDept, parms))
                {
                    return dt;
                }

            }
            else if (!string.IsNullOrEmpty(area))
            {
                using (DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifArea, parms))
                {
                    return dt;
                }
            }
            else
            {
                using (DataSet dt = SQLHelper.ExecuteDataSet(SQLHelper.ConnectionString, CommandType.Text, ifGlobal, parms))
                {
                    return dt;
                }
            }
        }



        /// <summary>
        /// 按片区查某年某季度某科室的上报信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DCNYJ QueryInfo(string startDate, string endDate, string dept, string area)
        {
            const string ifDept = @"select sum(hzjcls) as hzjcls,sum(yxzxls) as yxzxls,sum(wgl) as wgl,sum(xdj)as xdj,sum(sws)as sws,sum(wjcz)as wjcz,sum(tzq)as tzq,sum(xdbdw) as xdbdw,sum(ylfw)as ylfw,
sum(fhcs)as fhcs,sum(bzx) as bzx from DCNYJ where report_dept=@report_dept and convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate";
            const string ifTimeEqual = @"select hzjcls,yxzxls,wgl,xdj,sws,wjcz,tzq,xdbdw,ylfw,fhcs,bzx,other from DCNYJ where report_dept=@report_dept and convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate";
            const string ifArea = @"select sum(hzjcls) as hzjcls,sum(yxzxls) as yxzxls,sum(wgl) as wgl,sum(xdj)as xdj,sum(sws)as sws,sum(wjcz)as wjcz,sum(tzq)as tzq,sum(xdbdw) as xdbdw,sum(ylfw)as ylfw,
sum(fhcs)as fhcs,sum(bzx) as bzx from DCNYJ a ,Department b where a.report_dept=b.Deptid and convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate and b.DeptPQ=@AreaID";
            const string ifGlobal = @"select sum(hzjcls) as hzjcls,sum(yxzxls) as yxzxls,sum(wgl) as wgl,sum(xdj)as xdj,sum(sws)as sws,sum(wjcz)as wjcz,sum(tzq)as tzq,sum(xdbdw) as xdbdw,sum(ylfw)as ylfw,
sum(fhcs)as fhcs,sum(bzx) as bzx from DCNYJ where convert(char(7) ,report_date , 120)>=@startDate and convert(char(7) ,report_date , 120)<=@endDate";
            SqlParameter[] parms = {
                                        new SqlParameter("@startDate",SqlDbType.VarChar,25),
                                        new SqlParameter("@endDate",SqlDbType.VarChar,25),
										new SqlParameter("@report_dept",SqlDbType.VarChar,3),
                                        new SqlParameter("@AreaID",SqlDbType.NVarChar,7)
                                    };
            DCNYJ model = null;
            parms[0].Value = startDate;
            parms[1].Value = endDate;
            if (dept == "" && dept == null)
            {
                parms[2].Value = "";
            }
            else
            {
                parms[2].Value = dept;
            }
            parms[3].Value = area;
            if (dept != "" && dept != null && startDate != endDate)
            {
                using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, ifDept, parms))
                {
                    if (dr.Read())
                    {
                        model = LoadModel(dr);
                    }
                }
                return model;
            }
            else if (dept != "" && dept != null && startDate == endDate)
            {

                using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, ifTimeEqual, parms))
                {
                    if (dr.Read())
                    {
                        model = LoadModelIfTimeEqual(dr);
                    }
                }
                return model;
            }
            else if (!string.IsNullOrEmpty(area))
            {
                using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, ifArea, parms))
                {
                    if (dr.Read())
                    {
                        model = LoadModel(dr);
                    }
                }
                return model;
            }
            else
            {
                using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, ifGlobal, parms))
                {
                    if (dr.Read())
                    {
                        model = LoadModel(dr);
                    }
                }
                return model;
            }
        }

        private DCNYJ LoadModel(IDataReader dr)
        {
            DCNYJ model = new DCNYJ();
            if (dr["hzjcls"] != DBNull.Value)
                model.Hzzjcls = Convert.ToInt32(dr["hzjcls"]);
            if (dr["yxzxls"] != DBNull.Value)
                model.Yxzxls = Convert.ToInt32(dr["yxzxls"]);
            if (dr["wgl"] != DBNull.Value)
                model.Wgl = Convert.ToInt32(dr["wgl"]);
            if (dr["xdj"] != DBNull.Value)
                model.Xdj = Convert.ToInt32(dr["xdj"]);
            if (dr["sws"] != DBNull.Value)
                model.Sws = Convert.ToInt32(dr["sws"]);
            if (dr["wjcz"] != DBNull.Value)
                model.Wjcz = Convert.ToInt32(dr["wjcz"]);
            if (dr["tzq"] != DBNull.Value)
                model.Tzq = Convert.ToInt32(dr["tzq"]);
            if (dr["xdbdw"] != DBNull.Value)
                model.Xdbdw = Convert.ToInt32(dr["xdbdw"]);
            if (dr["ylfw"] != DBNull.Value)
                model.Ylfw = Convert.ToInt32(dr["ylfw"]);
            if (dr["fhcs"] != DBNull.Value)
                model.Fhcs = Convert.ToInt32(dr["fhcs"]);
            if (dr["bzx"] != DBNull.Value)
                model.Bzx = Convert.ToInt32(dr["bzx"]);
            return model;

        }

        private DCNYJ LoadModelIfTimeEqual(IDataReader dr)
        {
            DCNYJ model = new DCNYJ();
            if (dr["hzjcls"] != DBNull.Value)
                model.Hzzjcls = Convert.ToInt32(dr["hzjcls"]);
            if (dr["yxzxls"] != DBNull.Value)
                model.Yxzxls = Convert.ToInt32(dr["yxzxls"]);
            if (dr["wgl"] != DBNull.Value)
                model.Wgl = Convert.ToInt32(dr["wgl"]);
            if (dr["xdj"] != DBNull.Value)
                model.Xdj = Convert.ToInt32(dr["xdj"]);
            if (dr["sws"] != DBNull.Value)
                model.Sws = Convert.ToInt32(dr["sws"]);
            if (dr["wjcz"] != DBNull.Value)
                model.Wjcz = Convert.ToInt32(dr["wjcz"]);
            if (dr["tzq"] != DBNull.Value)
                model.Tzq = Convert.ToInt32(dr["tzq"]);
            if (dr["xdbdw"] != DBNull.Value)
                model.Xdbdw = Convert.ToInt32(dr["xdbdw"]);
            if (dr["ylfw"] != DBNull.Value)
                model.Ylfw = Convert.ToInt32(dr["ylfw"]);
            if (dr["fhcs"] != DBNull.Value)
                model.Fhcs = Convert.ToInt32(dr["fhcs"]);
            if (dr["bzx"] != DBNull.Value)
                model.Bzx = Convert.ToInt32(dr["bzx"]);
            if (dr["other"] != DBNull.Value)
                model.Other = dr["other"].ToString();
            return model;

        }

        /// <summary>
        /// 通用参数
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
                new SqlParameter("@other", SqlDbType.VarChar,1000),
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

        /// <summary>
        /// 通用参数
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private SqlParameter[] GetParmsIncludeDatetime(DCNYJ model, string StartDate, string EndDate)
        {
            SqlParameter[] parms = {		
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
                new SqlParameter("@other", SqlDbType.VarChar,1000),
                new SqlParameter("@startDate", SqlDbType.VarChar,1000),
                new SqlParameter("@endDate", SqlDbType.VarChar,1000),
				};
            parms[0].Value = model.Report_dept;
            parms[1].Value = model.Hzzjcls;
            parms[2].Value = model.Yxzxls;
            parms[3].Value = model.Wgl;
            parms[4].Value = model.Xdj;
            parms[5].Value = model.Sws;
            parms[6].Value = model.Wjcz;
            parms[7].Value = model.Tzq;
            parms[8].Value = model.Xdbdw;
            parms[9].Value = model.Ylfw;
            parms[10].Value = model.Fhcs;
            parms[11].Value = model.Bzx;
            parms[12].Value = model.Other;
            parms[13].Value = StartDate;
            parms[14].Value = EndDate;
            return parms;
        }
    }
}
