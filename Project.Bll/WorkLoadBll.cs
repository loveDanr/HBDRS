using Project.Dal;
using Project.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Project.Bll
{
    public class WorkLoadBll
    {
        private readonly WorkLoadDal dal = new WorkLoadDal();

        public int Insert(WorkLoad model)
        {
            return dal.Insert(model);
        }

        public DataTable QueryAllByDate(int year, int month)
        {
            return dal.QueryAllByDate(year, month);
        }

        public decimal GetWorkLoadSUM(int year, int month)
        {
            return dal.GetWorkLoadSUM(year,month);
        }
        public decimal GetWorkLoadAverage(int year, int month)
        {
            return dal.GetWorkLoadAverage(year,month);
        }
    }
}
