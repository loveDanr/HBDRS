using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    public class WorkLoad
    {
        private string gzlDate;

        public string GzlDate
        {
            get { return gzlDate; }
            set { gzlDate = value; }
        }
        private string gzlLoad;

        public string GzlLoad
        {
            get { return gzlLoad; }
            set { gzlLoad = value; }
        }
        private string operateUser;

        public string OperateUser
        {
            get { return operateUser; }
            set { operateUser = value; }
        }
        private string operateDate;

        public string OperateDate
        {
            get { return operateDate; }
            set { operateDate = value; }
        }
    }
}
