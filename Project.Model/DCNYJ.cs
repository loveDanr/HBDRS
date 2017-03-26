using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    /// <summary>
    /// 多重耐药菌——职能科室model
    /// </summary>
    public class DCNYJ
    {
        private int id;
        /// <summary>
        /// 序列号
        /// </summary>
        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        private string report_date;
        /// <summary>
        /// 上报日期
        /// </summary>
        public string Report_date
        {
            get { return report_date; }
            set { report_date = value; }
        }
        private string report_dept;
        /// <summary>
        /// 上报科室
        /// </summary>
        public string Report_dept
        {
            get { return report_dept; }
            set { report_dept = value; }
        }
        private int hzzjcls;
        /// <summary>
        /// 患者检出例（督导）次数
        /// </summary>
        public int Hzzjcls
        {
            get { return hzzjcls; }
            set { hzzjcls = value; }
        }
        private int yxzxls;
        /// <summary>
        /// 有效执行多重耐药菌医院感染核心防控措施的例次数
        /// </summary>
        public int Yxzxls
        {
            get { return yxzxls; }
            set { yxzxls = value; }
        }
        private int wgl;
        /// <summary>
        /// 未隔离
        /// </summary>
        public int Wgl
        {
            get { return wgl; }
            set { wgl = value; }
        }
        private int xdj;
        /// <summary>
        /// 消毒剂
        /// </summary>
        public int Xdj
        {
            get { return xdj; }
            set { xdj = value; }
        }
        private int sws;
        /// <summary>
        /// 手卫生
        /// </summary>
        public int Sws
        {
            get { return sws; }
            set { sws = value; }
        }
        private int wjcz;
        /// <summary>
        /// 无菌技术操作不规范
        /// </summary>
        public int Wjcz
        {
            get { return wjcz; }
            set { wjcz = value; }
        }
        private int tzq;
        /// <summary>
        /// 听诊器等未做到专人专用
        /// </summary>
        public int Tzq
        {
            get { return tzq; }
            set { tzq = value; }
        }
        private int xdbdw;
        /// <summary>
        /// 消毒不到位
        /// </summary>
        public int Xdbdw
        {
            get { return xdbdw; }
            set { xdbdw = value; }
        }
        private int ylfw;
        /// <summary>
        /// 医疗废物
        /// </summary>
        public int Ylfw
        {
            get { return ylfw; }
            set { ylfw = value; }
        }
        private int fhcs;
        /// <summary>
        /// 防护措施不到位
        /// </summary>
        public int Fhcs
        {
            get { return fhcs; }
            set { fhcs = value; }
        }
        private int bzx;
        /// <summary>
        /// 不知晓患者情况
        /// </summary>
        public int Bzx
        {
            get { return bzx; }
            set { bzx = value; }
        }
        private int other;
        /// <summary>
        /// 其他
        /// </summary>
        public int Other
        {
            get { return other; }
            set { other = value; }
        }
    }
}
