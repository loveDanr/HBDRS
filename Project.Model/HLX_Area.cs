using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Project.Model
{
    public class HLX_Area
    {
        private string  _areaID;
        private string _areaName;
        private string _areaManager;
        List<string> _includeDeptIDs;

        public List<string> IncludeDeptIDs
        {
            get { return _includeDeptIDs; }
            set { _includeDeptIDs = value; }
        }

        /// <summary>
        /// 主键
        /// </summary>
        public string AreaID
        {
            get { return _areaID; }
            set { _areaID = value; }
        }
        /// <summary>
        /// 片区名称
        /// </summary>
        public string AreaName
        {
            get { return _areaName; }
            set { _areaName = value; }
        }
        /// <summary>
        /// 片区负责人
        /// </summary>
        public string AreaManager
        {
            get { return _areaManager; }
            set { _areaManager = value; }
        }


    }
}
