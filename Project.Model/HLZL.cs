using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    public class HLZL
    {
        private int _id;
        private string _report_date;
        private string _report_dept;
        private decimal _bb_zrhs;
        private decimal _yb_zrhs;
        private decimal _bb_szhz;
        private decimal _yb_szhz;
        private decimal _zg_work_time;
        private decimal _wcg_days;
        private decimal _zy_stys;
        private decimal _yc_gwhz;
        private decimal _zc_ddhz;
        private int _report_season;
        private string _report_year;

        /// <summary>
        /// 主键
        /// </summary>
        public int id
        {
            get {return  _id; }
            set { _id = value; }
        }
        /// <summary>
        /// 上报日期
        /// </summary>
        public string report_date 
        {
            get { return _report_date; }
            set { _report_date = value; }
        }
        /// <summary>
        /// 上报科室
        /// </summary>
        public string report_dept
        {
            get { return _report_dept; }
            set { _report_dept = value; }
        }
        /// <summary>
        /// 白班责任护士人数
        /// </summary>
        public decimal bb_zrhs
        {
            get { return _bb_zrhs; }
            set { _bb_zrhs = value; }
        }
        /// <summary>
        /// 夜班责任护士人数
        /// </summary>
        public decimal yb_zrhs
        {
            get { return _yb_zrhs; }
            set { _yb_zrhs = value; }
        }
        /// <summary>
        /// 白班收治患者数
        /// </summary>
        public decimal bb_szhz
        {
            get { return _bb_szhz; }
            set { _bb_szhz = value; }
        }
        /// <summary>
        /// 夜班收治患者数
        /// </summary>
        public decimal yb_szhz
        {
            get { return _yb_szhz; }
            set { _yb_szhz = value; }
        }
        /// <summary>
        /// 在岗执业护士实际上班小时数
        /// </summary>
        public decimal zg_work_time
        {
            get { return _zg_work_time; }
            set { _zg_work_time = value; }
        }
        /// <summary>
        /// 胃肠管（经口鼻）留置总日数
        /// </summary>
        public decimal wcg_days
        {
            get { return _wcg_days; }
            set { _wcg_days = value; }
        }
        /// <summary>
        /// 住院患者身体约束日数
        /// </summary>
        public decimal zy_stys
        {
            get { return _zy_stys; }
            set { _zy_stys = value; }
        }
        /// <summary>
        /// 压疮高危患者例数
        /// </summary>
        public decimal yc_gwhz
        {
            get { return _yc_gwhz; }
            set { _yc_gwhz = value; }
        }
        /// <summary>
        /// 坠床/跌倒高危患者例数
        /// </summary>
        public decimal zc_ddhz
        {
            get { return _zc_ddhz; }
            set { _zc_ddhz = value; }
        }
        /// <summary>
        /// 上报季度
        /// </summary>
        public int report_season
        {
            get { return _report_season; }
            set { _report_season = value; }
        }
        /// <summary>
        /// 上报年份
        /// </summary>
        public string report_year
        {
            get { return _report_year; }
            set { _report_year = value; }
        }
    }
}
