using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Project.Model;
using System.Data.SqlClient;
using Project.Common;
using System.Data;

namespace Project.Dal
{
    public class WorkLoadDal
    {
        public int Insert(WorkLoad model)
        {

            int n = 0;
            using (SqlConnection connection = new SqlConnection(SQLHelper.ConnectionString))
            {
                connection.Open();

                SqlCommand command = connection.CreateCommand();
                SqlTransaction transaction;

                transaction = connection.BeginTransaction("WorkLoadSave");

                command.Connection = connection;
                command.Transaction = transaction;

                try
                {
                    command.CommandText =
                        "DELETE FROM WorkLoad  WHERE GzlDate=@GzlDate AND Operator=@Operator";
                    SqlParameter[] parmsD = {						
							new SqlParameter("@GzlDate",SqlDbType.Date),
                            new SqlParameter("@Operator",SqlDbType.NVarChar,50)
		            };
                    parmsD[0].Value = model.GzlDate;
                    parmsD[1].Value = model.OperateUser;
                    command.Parameters.AddRange(parmsD);
                    command.ExecuteNonQuery();
                    command.Parameters.Clear();

                    command.CommandText =
                        "INSERT INTO [WorkLoad]([GzlDate], [GzlLoad], [Operator], [OperateDate]) VALUES (@GzlDate,@GzlLoad,@Operator,@OperateDate)";
                    SqlParameter[] parms = GetParms(model);
                    command.Parameters.AddRange(parms);
                    n = command.ExecuteNonQuery();


                    transaction.Commit();

                }
                catch (Exception ex)
                {
                    Common.LogHelper.WriteLog(this.GetType(), ex);
                    try
                    {
                        transaction.Rollback();
                    }
                    catch (Exception ex2)
                    {
                        // This catch block will handle any errors that may have occurred
                        // on the server that would cause the rollback to fail, such as
                        // a closed connection.
                        Common.LogHelper.WriteLog(this.GetType(), ex2);
                    }
                }
            }





            return n;
        }


        private SqlParameter[] GetParms(WorkLoad model)
        {
            SqlParameter[] parms = {
				new SqlParameter("@GzlDate", SqlDbType.Date),			
				new SqlParameter("@GzlLoad", SqlDbType.Float),			
				new SqlParameter("@Operator", SqlDbType.VarChar, 50),			
                new SqlParameter("@OperateDate", SqlDbType.DateTime),
				};

            parms[0].Value = model.GzlDate;
            parms[1].Value = model.GzlLoad;
            parms[2].Value = model.OperateUser;
            parms[3].Value = model.OperateDate;
            return parms;
        }

        public int Delete(string date, string operateUser, SqlTransaction trans)
        {
            const string sql = "DELETE FROM WorkLoad  WHERE GzlDate=@GzlDate AND Operator=@Operator";

            SqlParameter[] parms = {						
							new SqlParameter("@GzlDate",SqlDbType.Date),
                            new SqlParameter("@Operator",SqlDbType.NVarChar,50)
		    };
            parms[0].Value = date;
            parms[1].Value = operateUser;
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

        public DataTable QueryAllByDate(int year, int month)
        {
            DataTable dt = new DataTable(); ;
            string sql = @"SELECT (select username FROM UserInfo where userid=operator ) operateUser,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31]
,(isnull([1],0)+isnull([2],0)+isnull([3],0)+isnull([4],0)+isnull([5],0)+isnull([6],0)+isnull([7],0)+isnull([8],0)+isnull([9],0)+isnull([10],0)+isnull([11],0)+isnull([12],0)+isnull([13],0)+isnull([14],0)+isnull([15],0)+isnull([16],0)+isnull([17],0)+isnull([18],0)+isnull([19],0)+isnull([20],0)+isnull([21],0)+isnull([22],0)+isnull([23],0)+isnull([24],0)+isnull([25],0)+isnull([26],0)+isnull([27],0)+isnull([28],0)+isnull([29],0)+isnull([30],0)+isnull([31],0)) as hj
                from (
                        select  day(gzlDate) gzlDay, gzlLoad,operator
                        FROM [WorkLoad]
                        where YEAR(gzlDate)=@dateYear AND MONTH(gzlDate)=@dateMonth
                ) ttb
                pivot
                (
	                sum(gzlload) FOR gzlDay in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])
                ) pivotTA";
            SqlParameter[] parms = {						
							new SqlParameter("@dateYear",SqlDbType.Int),
                            new SqlParameter("@dateMonth",SqlDbType.Int)
		    };
            parms[0].Value = year;
            parms[1].Value = month;

            try
            {
                dt = SQLHelper.GetDataTable(CommandType.Text, sql, parms);
            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }

            return dt;
        }

        public decimal GetWorkLoadSUM(int year, int month)
        {
            const string sql = "select sum(gzlLoad) from workload where YEAR(gzlDate)=@dateYear AND MONTH(gzlDate)=@dateMonth";

            SqlParameter[] parms = {						
							new SqlParameter("@dateYear",SqlDbType.Int),
                            new SqlParameter("@dateMonth",SqlDbType.Int)
		    };
            parms[0].Value = year;
            parms[1].Value = month;
            object n = null;
            try
            {

                n = SQLHelper.ExecuteScalar(SQLHelper.ConnectionString, CommandType.Text, sql, parms);
                if (System.DBNull.Value == n)
                {
                    n = 0;
                }

            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }
            return Convert.ToDecimal(n);
        }

        public decimal GetWorkLoadAverage(int year, int month)
        {
            const string sql = "select sum(gzlLoad)/count(*) from workload where YEAR(gzlDate)=@dateYear AND MONTH(gzlDate)=@dateMonth";

            SqlParameter[] parms = {						
							new SqlParameter("@dateYear",SqlDbType.Int),
                            new SqlParameter("@dateMonth",SqlDbType.Int)
		    };
            parms[0].Value = year;
            parms[1].Value = month;
            object n = null;
            try
            {

                n = SQLHelper.ExecuteScalar(SQLHelper.ConnectionString, CommandType.Text, sql, parms);
                if (System.DBNull.Value == n)
                {
                    n = 0;
                }
            }
            catch (Exception ex)
            {
                Common.LogHelper.WriteLog(this.GetType(), ex);
            }
            return Convert.ToDecimal(n);
        }
    }
}
