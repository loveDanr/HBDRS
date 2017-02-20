using Project.Common;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Project.Dal
{
    public class BzswbDal
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public List<Model.Bzswb> getKS()
        {
            string sql = "select * from BZSWB_tf where sj=convert(varchar(7),getdate(),120)";
            List<Model.Bzswb> list = new List<Model.Bzswb>();
            using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, null))
            {
                while (dr.Read())
                {
                    Model.Bzswb bz = new Model.Bzswb();
                    bz.Sl = dr[0].ToString();
                    bz.Ks = dr[1].ToString();
                    bz.Sbr = dr[2].ToString();
                    bz.Rq = dr[3].ToString();
                    bz.Sj = dr[4].ToString();
                    list.Add(bz);
                }
            }
            return list;


        }
        /// <summary>
        /// 向洁具表中插入数据
        /// </summary>
        /// <param name="dpt">实体类的对象</param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int insertBzswb(Bzswb Bbd, SqlTransaction trans)
        {
            int n = 0;

            string sql = "insert into BZSWB_tf  values(@sl,@ks,@sbr,@rq,CONVERT(varchar, getdate(), 120 ))";
            SqlParameter[] parms = GetParms(Bbd);
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
        private SqlParameter[] GetParms(Bzswb Bbd)
        {
            SqlParameter[] parms ={
                                    new SqlParameter ("@sl",SqlDbType.NVarChar,50),
                                    new SqlParameter ("@ks",SqlDbType.NVarChar,50),
                                    new SqlParameter("@sbr",SqlDbType.NVarChar,50),
                                    new SqlParameter("@rq",SqlDbType.NVarChar ,50)
                                    
                                    
                                };

            parms[0].Value = Bbd.Sl;
            parms[1].Value = Bbd.Ks;
            parms[2].Value = Bbd.Sbr;
            parms[3].Value = Bbd.Rq;


            return parms;
        }
        /// <summary>
        /// 获取科室和日期，用来判断该科室是否有上报记录
        /// </summary>
        /// <returns></returns>
        public int CheckKSIDExist(Bzswb bw, SqlTransaction trans)
        {
            string sql = "select count(*) from bzswb_tf where ks=@ks and rq=@rq";
            SqlParameter[] parms = GetParms(bw);
            int n = 0;
            try
            {
                if (trans == null)
                {
                    n = Convert.ToInt32(SQLHelper.ExecuteScalar(SQLHelper.ConnectionString, CommandType.Text, sql, parms));
                }
                else
                {
                    n = Convert.ToInt32(SQLHelper.ExecuteNonQuery(trans, CommandType.Text, sql, parms));
                }

            }
            catch (Exception)
            {
                throw;

            }
            return n;
        }
        /// <summary>
        /// 根据开始时间，结束时间，科室查询申报情况
        /// </summary>
        /// <param name="begin">开始时间</param>
        /// <param name="end">结束时间</param>
        /// <param name="cks">科室</param>
        /// <returns>数据集</returns>
        public DataSet queryTime(string  begin, string  end, string cks)
        {
            //string sql = "select sl,(select deptname  from department where deptid = ks) ks, sbr,[rq],[sj] from BZSWB_tf where rq >=" + begin + "  rq ="+end+"  ks =" + cks + " ";
            string sql = "select [sl],(select deptname  from department where deptid = [ks]) ks,(select username  from userinfo where userid = sbr) sbr,[rq],[sj] from BZSWB_tf where rq >='" + begin + "'and rq <= '" + end + "'  and ks = '" + cks + "'";
            DataSet ds = new DataSet();
            
            try
            {
                SqlConnection conn = new SqlConnection(SQLHelper.ConnectionString);
                SqlDataAdapter sda = new SqlDataAdapter(sql, conn);
                
                sda.Fill(ds);
                
            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

        /// <summary>
        /// 查询当天申报的数据
        /// </summary>
        /// <returns></returns>
        public DataSet queryTime()
        {
            string sql = "select * from BZSWB_tf where rq = convert(varchar(7),getdate(),120)";
            DataSet ds = new DataSet();
            SqlConnection conn = new SqlConnection(SQLHelper.ConnectionString);
            try
            {
                conn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sql, conn);
                sda.Fill(ds);
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
            return ds;
        }
        /// <summary>
        /// 删除上报的数据
        /// </summary>
        /// <param name="ks"></param>
        /// <param name="rq"></param>
        /// <returns></returns>
        public int delBzswbSb(string ks,string rq)
        {
            int n = 0;
            string sql = "delete from BZSWB_tf where ks=@ks and rq=@rq";
            SqlConnection conn = new SqlConnection(SQLHelper.ConnectionString);
            SqlCommand sqlcmd = new SqlCommand(sql, conn);
            sqlcmd.Parameters.Add(new SqlParameter("@ks",ks ));

            sqlcmd.Parameters.Add(new SqlParameter("@rq",rq ));
            try
            {
                conn.Open();
                n = sqlcmd.ExecuteNonQuery();

            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                conn.Close();
            }
            return n;

 
        }
        /// <summary>
        /// 根据时间查询上报数据
        /// </summary>
        /// <param name="sj"></param>
        /// <returns></returns>
        public DataSet queryTime(string sj)
        {
            string sql = "select [sl],ks,(select deptname  from department where deptid = [ks]) ksName,(select username  from userinfo where userid = sbr) sbr,[rq],[sj] from BZSWB_tf where rq >='"+sj+"'";
            DataSet ds = new DataSet();

            try
            {
                SqlConnection conn = new SqlConnection(SQLHelper.ConnectionString);
                SqlDataAdapter sda = new SqlDataAdapter(sql, conn);

                sda.Fill(ds);

            }
            catch (Exception)
            {

                throw;
            }
            return ds;
        }

      
    }
}
        