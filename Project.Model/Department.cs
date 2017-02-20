using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
   /// <summary>
   /// 部门
   /// </summary>
  public  class Department
    {
      
        private string deptID;

        public string DeptID
        {
            get { return deptID; }
            set { deptID = value; }
        }
        private string partntDeptID;

        public string PartntDeptID
        {
            get { return partntDeptID; }
            set { partntDeptID = value; }
        }
        private string deptName;

        public string DeptName
        {
            get { return deptName; }
            set { deptName = value; }
        }
        private string deptPym;

        public string DeptPym
        {
            get { return deptPym; }
            set { deptPym = value; }
        }
        private int deptOrderNum;

        public int DeptOrderNum
        {
            get { return deptOrderNum; }
            set { deptOrderNum = value; }
        }
        private string  deptFunc;

        public string  DeptFunc
        {
            get { return deptFunc; }
            set { deptFunc = value; }
        }
        private string deptPQ;

        public string DeptPQ
        {
            get { return deptPQ; }
            set { deptPQ = value; }
        }
    }
}
