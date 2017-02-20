using System;
using System.Collections.Generic;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;
using System.Data;

namespace Project.Bll
{
    ///Title: HLZLBll类
    ///Description: 护理质量数据上报业务逻辑操作类
    ///
    ///@version 1.0.0.0
    ///
    ///@modify 
    ///@date 
     
    public class HLZLBll
    {
        private readonly HLZLDal dal = new HLZLDal();
        /// <summary>
        /// 插入一条的护理质量新记录的方法
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Insert(HLZL model, SqlTransaction trans)
        {
            return dal.Insert(model, trans);
        }
        /// <summary>
        /// 删除一条记录的方法
        /// </summary>
        /// <param name="id"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Del(int id, SqlTransaction trans)
        {
            return dal.Delete(id, trans);
        }
        /// <summary>
        /// 查看上报记录是否已存在
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int CheckExist(HLZL model, SqlTransaction trans)
        {
            return dal.CheckExist(model, trans);
        }


        /// <summary>
        /// 按片区查某年某季度某科室的上报信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DataSet GetReportInfo(string year, int season, string dept, string area)
        {
            return dal.QueryInfo(year, season, dept, area);
            
        }
        /// <summary>
        /// 绑定年份
        /// </summary>
        /// <returns></returns>
        public DataSet GetYear()
        {
            return dal.BindYear();
        }




    }
}
