using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    public class QJ_Total
    {
        private string _UserID;
        private int _TotalDays;
        private int _RestDays;
        private int _LastDays;

        /// <summary>
        ///用户ID
        /// </summary>
        public string UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }

        /// <summary>
        /// 共有假期天数
        /// </summary>
        public int TotalDays
        {
            get { return _TotalDays; }
            set { _TotalDays = value; }
        }
        /// <summary>
        /// 已经休息的天数
        /// </summary>
        public int RestDays
        {
            get { return _RestDays; }
            set { _RestDays = value; }
        }

        /// <summary>
        /// 剩余假期天数
        /// </summary>
        public int LastDays
        {
            get { return _LastDays; }
            set { _LastDays = value; }
        }
    }
}
