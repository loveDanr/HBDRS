using Project.Dal;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Project.Bll
{
    public class BzswbBll
    {
        private readonly BzswbDal BDal = new BzswbDal();
        /// <summary>
        /// 查询页面默认加载的页面
        /// </summary>
        /// <returns></returns>
        public List<Model.Bzswb> getKS()
        {
            return BDal.getKS();
        }
        public int insertBzswb(Bzswb dpt, SqlTransaction trans)
        {
            return BDal.insertBzswb(dpt, trans);
        }
        /// <summary>
        /// 获取科室，用来判断该科室是否有上报记录
        /// </summary>
        /// <returns></returns>
        public int CheckKSIDExist(Bzswb bw, SqlTransaction trans)
        {
            return BDal.CheckKSIDExist(bw,trans);
        }
        public DataSet queryTime(string  begin, string end, string cks)
        {
            return BDal.queryTime(begin,end,cks);
 
        }
        public DataSet queryTime()
        {
            return BDal.queryTime();
        }
        public int delBzswbSb(string ks, string rq)
        {
            return BDal.delBzswbSb(ks,rq);
        }
        public DataSet queryTime(string sj)
        {
            return BDal.queryTime(sj);
        }

    }
}
