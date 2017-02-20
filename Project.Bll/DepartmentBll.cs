using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Project.Model;
using Project.Dal;
using System.Data.SqlClient;

namespace Project.Bll
{
   public class DepartmentBll
    {
       private readonly DepartmentDal dal = new DepartmentDal();
       /// <summary>
       /// 获取顶级菜单
       /// </summary>
       /// <returns>返回顶级菜单列表</returns>
       public List<Department> getTopList()
       {
           return dal.GetTopList();
       }
       public List<Department> getOrderList( List<Department> list)
       {
           if (list!=null||list.Count>0)
           {
               List<Department> newlist = new  List<Department>();
               List<Department> parentlist = list.FindAll(delegate(Department dpt) { return Convert.ToInt32(dpt.PartntDeptID) != -1; });
               for (int i = 0; i < parentlist.Count; i++)
               {
                   newlist.Add(parentlist[i]);
                   //newlist.AddRange(list.FindAll(delegate(Department dpt) { return Convert.ToInt32(dpt.DeptID) ==Convert.ToInt32 ( parentlist[i].PartntDeptID); }));
               }
               return newlist;
           }
           else
               return null;
       }
       /// <summary>
       /// 通过部门编号获取该部门
       /// </summary>
       /// <param name="id"> 部门ID</param>
       /// <returns>实体部门</returns>
       public Department GetDepartment(string id)
       {
          return dal.GetDepartment(id);
          
       }

       public int InsertDep(Department dpt, SqlTransaction trans)
       {
          return  dal.InsertDep(dpt,trans);
       }

       public int UpdateDepartment(Department dpt, SqlTransaction trans)
       {
           return dal.UpdateDepartment(dpt,trans );
       }
       public int DelDepartment(string id, SqlTransaction trans)
       {
           return dal.DelDepartment(id,trans);
       }
       //public Department GetDepartment()
       //{
       //    return dal.GetDepartment();

       //}
       /// <summary>
       /// 查询科室编号是否存在
       /// </summary>
       /// <param name="dpt"></param>
       /// <param name="trans"></param>
       /// <returns>返回数量</returns>
       public int CheckKSIDExist(Department dpt, SqlTransaction trans)
       {
           return dal.CheckKSIDExist(dpt,trans );
       }
       /// <summary>
       /// 更新片区
       /// </summary>
       /// <param name="dpt"></param>
       /// <param name="trans"></param>
       /// <returns></returns>
       public int UpdatePQ(string deptID,  string areaID,SqlTransaction trans)
       {
           return dal.UpdatePQ(deptID, areaID, trans);
       }
    }
}
