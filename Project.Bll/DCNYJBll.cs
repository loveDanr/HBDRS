using System;
using System.Collections.Generic;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;
using System.Data;

namespace Project.Bll
{
    public class DCNYJBll
    {
        private readonly DCNYJDal dal = new DCNYJDal();
        /// <summary>
        /// 插入一条的多重耐药菌新记录的方法
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Insert(DCNYJ model, SqlTransaction trans)
        {
            return dal.Insert(model, trans);
        }
        /// <summary>
        /// 修改记录
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Update(DCNYJ model,string startdate,string enddate, SqlTransaction trans)
        {
            return dal.Update(model,startdate,enddate,trans);
        }
        /// <summary>
        /// 绑定GridView数据源
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="dept"></param>
        /// <param name="area"></param>
        /// <returns></returns>
        public DataSet QueryOther(string startDate, string endDate, string dept, string area)
        {
            return dal.QueryOther(startDate,endDate,dept,area);
        }

        /// <summary>
        /// 查某年某月某科室的上报信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DCNYJ GetReportInfo(string startDate, string endDate, string dept, string area)
        {
            return dal.QueryInfo(startDate, endDate, dept, area);

        }

        /// <summary>
        /// 查看上报记录是否已存在
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int CheckExist(DCNYJ model, SqlTransaction trans)
        {
            return dal.CheckExist(model, trans);
        }


    }
}
