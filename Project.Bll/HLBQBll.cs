using System;
using System.Collections.Generic;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;
using System.Data;
using Project.Bll;

namespace Project.Bll
{
   public class HLBQBll
    {
       private readonly HLBQDal dal = new HLBQDal();

      /// <summary>
        /// 获取已归属片区的科室
        /// </summary>
        /// <param name="areaID"></param>
        /// <returns></returns>
        public DataTable GetDeptInArea(string areaID)
        {
            return dal.GetDeptInArea(areaID);
        }
        /// <summary>
        /// 获取未归属片区的科室
        /// </summary>
        /// <returns></returns>
        public DataTable GetDeptNotInArea()
        {
            return dal.GetDeptNotInArea();
        }
        /// <summary>
        /// 读取所有片区
        /// </summary>
        /// <returns></returns>
        public DataTable GetallHLX_Area()
        {
            if (dal.GetallHLX_Area() != null)
            {
                return dal.GetallHLX_Area();
            }
            else
            {
                return new DataTable();
            }
        }
       /// <summary>
       /// 新增护理病区
       /// </summary>
       /// <param name="model"></param>
       /// <param name="trans"></param>
       /// <returns></returns>
        public int Insert(HLX_Area model, SqlTransaction trans)
        {
            return dal.Insert(model,trans);
        }

        /// <summary>
        /// 删除护理病区
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Delete(HLX_Area model)
        {
            
            return dal.Delete(model,null);
        }
        /// <summary>
        /// 更新护理病区
        /// </summary>
        /// <param name="model"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Update(HLX_Area model)
        {
            return dal.Update(model, null);
        }
    }
}
