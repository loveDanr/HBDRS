using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Project.Model;
using Project.Common;

namespace Project.Dal
{
  public   class DepartmentDal
    {
      /// <summary>
      /// 获取部门表中的所有部门
      /// </summary>
      /// <returns>返回部门表的集合</returns>
      public List<Department> GetTopList()
      {
          List<Department> list = new List<Department>();
          string sql = "select * from department WHERE ParentDeptID <> -1";
          using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, null))
          {
              
              while (dr.Read())
              {
                  Department dpt = new Department();
                  dpt.DeptID = dr[0].ToString();
                  dpt.PartntDeptID = dr[1].ToString();
                  dpt.DeptName = dr[2].ToString();
                  dpt.DeptPym = dr[3].ToString();
                  dpt.DeptOrderNum = dr.GetInt32(4);
                  dpt.DeptFunc = dr[5].ToString();
                  list.Add(dpt);
                  
              }
              
          }
          return list;
      }
      /// <summary>
      /// 在Department中新增一条记录
      /// </summary>
      /// <param name="dpt">被查入数据的实体对象</param>
      /// <param name="trans">事务参数</param>
      /// <returns>返回的行数</returns>
      public int InsertDep(Department dpt,SqlTransaction trans)
      {
          int n=0;
          const string sql = "insert into department(deptID,parentdeptID,deptName,deptpym,deptordernum,deptfunc,deptPQ) values(@deptID,@parentdeptID,@deptName,@deptpym,@deptordernum,@deptfunc,null)";

          SqlParameter[] parms = GetParms(dpt);

          try
          {
              if (trans == null)
                  n = SQLHelper.ExecuteNonQuery(SQLHelper.ConnectionString, CommandType.Text, sql, parms);
              else
                  n = SQLHelper.ExecuteNonQuery(trans,CommandType.Text,sql,parms );
          }
          catch (Exception)
          {
              
              throw;
          }


          return n;
      }

      private SqlParameter[] GetParms(Department  dpt)
      {
          SqlParameter[] parms ={
                                    new SqlParameter ("@DeptID",SqlDbType.NVarChar,3),
                                    new SqlParameter ("@ParentDeptID",SqlDbType.NVarChar,3),
                                    new SqlParameter("@DeptName",SqlDbType.NVarChar,50),
                                    new SqlParameter("@DeptPYM",SqlDbType.NVarChar ,50),
                                    new SqlParameter("@DeptOrderNum",SqlDbType.Int,4),
                                    new SqlParameter ("@DeptFunc",SqlDbType.NVarChar,50),
                                    new SqlParameter("@DeptPQ",SqlDbType.NVarChar,7)
                                };
          parms[0].Value = dpt.DeptID;
          parms[1].Value = dpt.PartntDeptID;
          parms[2].Value = dpt.DeptName;
          parms[3].Value = dpt.DeptPym;
          parms[4].Value = dpt.DeptOrderNum;
          parms[5].Value = dpt.DeptFunc;
          parms[6].Value = dpt.DeptPQ;
          return parms;
      }
      private SqlParameter[] GetParmsID(Department dpt)
      {
          SqlParameter[] parms ={ new SqlParameter ("@DeptID",SqlDbType.NVarChar,3)
                               };
          parms[0].Value = dpt.DeptID;
          return parms;
 
      }
      
      /// <summary>
      /// 获取该部门的信息
      /// </summary>
      /// <param name="id">获取参数ID</param>
      /// <returns>返回department实体类</returns>

      public Department GetDepartment(string id)
      {

          Department dpt = new Department();
          string sql = "select * from department where deptID=@id";
          SqlParameter[] parms = {						
							new SqlParameter("@id",SqlDbType.Char,3)};
          parms[0].Value = id;
          using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, parms))
          {

              while (dr.Read())
              {
                  
                  dpt.DeptID = dr[0].ToString();
                  dpt.PartntDeptID = dr[1].ToString();
                  dpt.DeptName = dr[2].ToString();
                  dpt.DeptPym = dr[3].ToString();
                  dpt.DeptOrderNum = dr.GetInt32(4);
                  dpt.DeptFunc = dr[5].ToString();
                  
              }

          }
          return dpt;
          
      }
      /// <summary>
      /// 更新部门信息
      /// </summary>
      /// <param name="dpt"></param>
      /// <param name="trans"></param>
      /// <returns></returns>
      public int UpdateDepartment(Department dpt, SqlTransaction trans)
      {
          const string sql = "UPDATE Department SET DeptID=@DeptID, ParentDeptId=@ParentDeptId, DeptName=@DeptName, DeptPYM=@DeptPYM, DeptOrderNum=@DeptOrderNum,DeptFunc=@DeptFunc WHERE 1=1 and  DeptID=@DeptID";

          SqlParameter[] parms = GetParms(dpt);

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
      /// 根据部门ID删除该部门的信息
      /// </summary>
      /// <param name="id"></param>
      /// <param name="trans"></param>
      /// <returns></returns>
      public int DelDepartment(string id,SqlTransaction trans)
      { 
          const string sql="delete from department where 1=1 and deptid=@deptid";
          SqlParameter[] parms={
              new SqlParameter("@deptid",SqlDbType.VarChar,5)
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
      /// 
      /// 获取部门的信息
      /// </summary>
      /// <returns>返回部门类型</returns>
      //public Department GetDepartment()
      //{

      //    Department dpt = new Department();
      //    string sql = "select * from department";
          
      //    using (SqlDataReader dr = SQLHelper.ExecuteReader(SQLHelper.ConnectionString, CommandType.Text, sql, null))
      //    {

      //        while (dr.Read())
      //        {

      //            dpt.DeptID = dr[0].ToString();
      //            dpt.PartntDeptID = dr[1].ToString();
      //            dpt.DeptName = dr[2].ToString();
      //            dpt.DeptPym = dr[3].ToString();
      //            dpt.DeptOrderNum = dr.GetInt32(4);
      //            dpt.DeptFunc = dr[5].ToString();

      //        }

      //    }
      //    return dpt;

      //}

      public int CheckKSIDExist(Department dpt,SqlTransaction trans)
      {
          string sql = "select count(*) from department where deptid=@deptid";
          SqlParameter[] parms = GetParmsID(dpt);
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
          catch (Exception ex)
          {
              Common.LogHelper.WriteLog(this.GetType(), ex);
              
          }
          return n;
      }
      /// <summary>
      /// 更新片区ID
      /// </summary>
      /// <param name="dpt"></param>
      /// <param name="trans"></param>
      /// <returns></returns>
      public int UpdatePQ(string deptID, string areaID, SqlTransaction trans)
      {
          const string sql = "UPDATE Department SET DeptPq=@DeptPQ where DeptID=@DeptID";

          SqlParameter[] parms ={
              new SqlParameter("@DeptPQ",SqlDbType.NVarChar,7),
              new SqlParameter("@DeptID",SqlDbType.VarChar,3)
          };
          parms[0].Value = areaID;
          parms[1].Value = deptID;
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




    }
}
