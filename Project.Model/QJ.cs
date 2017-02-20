using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    ///========================================================================
    /// Project: 请假页面model	
    ///========================================================================
    /// <summary>
    ///Title: QJ类
    ///Description: dbo.QJ_leave数据表实体模型代码
    ///
    ///@version 1.0.0.0
    ///
    ///@modify 
    ///@date 
    /// </summary>
    public class QJ
    {
        private int _id;
        private string _UserID;
        private string _QjDate;
        private int _QjDays;
        private int _TotalDays;
        private string _Reason;
        private string _ApproverId;


        /// <summary>
        /// 主键，id
        /// </summary>
        public int id
        {
            get { return _id;}
            set{_id = value;}
        }

        /// <summary>
        ///用户ID
        /// </summary>
        public string UserID
        {
            get { return  _UserID; }
            set { _UserID = value; }
        }
        /// <summary>
        /// 请假日期
        /// </summary>
        public string QjDate
        {
            get { return _QjDate; }
            set { _QjDate = value; }
        }
        /// <summary>
        /// 请假天数
        /// </summary>
        public int QjDays
        {
            get { return _QjDays; }
            set { _QjDays = value; }
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
        /// 请假原因
        /// </summary>
        public string Reason
        {
            get { return _Reason; }
            set { _Reason = value; }
        }
        /// <summary>
        /// 批准人
        /// </summary>
        public string ApproverId
        {
            get { return _ApproverId; }
            set { _ApproverId = value; }
        }
    }
}
