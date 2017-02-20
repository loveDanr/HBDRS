using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
using System.Collections;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using Project.WebUi.App_Code;

namespace Project.WebUi.GZCX
{
    public partial class index : MyBasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxDateEdit1.DateTime = System.DateTime.Now.Date.AddDays(-DateTime.Now.Day + 1);
                ASPxDateEdit2.DateTime = System.DateTime.Now;
                ASPxGridView1.SettingsDataSecurity.AllowDelete = false;
                ASPxGridView1.SettingsDataSecurity.AllowEdit = false;
                ASPxGridView1.SettingsDataSecurity.AllowInsert = false;

            }
            Chax();
            string iri = ConfigurationManager.AppSettings["ImportRoleID"];
            // 财务科 导入工资
            if ( (!string.IsNullOrEmpty(iri))&&loginUser.RoleId.IndexOf(iri) > -1)
            {
                fupExcel.Visible = true;
                ASPxButtonImport.Visible = true;
                lblMessages.Visible = true;
                ASPxButtonClear.Visible = true;
            }
            else
            {
                fupExcel.Visible = false;
                ASPxButtonImport.Visible = false;
                lblMessages.Visible = false;
                ASPxButtonClear.Visible = false;
            }

        }

        protected void Chax()
        {

            string sc;
            string dept = string.Empty;
            string deptid = string.Empty;


            //sc = "select * from CWX_GZ where 时间>='" + ASPxDateEdit1.Date.ToString("yyyy-MM-dd") + "' and 时间 <='" + ASPxDateEdit2.Date.ToString("yyyy-MM-dd") + "'";
            sc = "select * from CWX_GZ where 签字>='" + ASPxDateEdit1.DateTime.ToString("yyyyMM") + "' and 签字 <='" + ASPxDateEdit2.DateTime.ToString("yyyyMM") + "'";

            sc += " and 人员编号='" + loginUser.UserId + "'";

            SqlDataSource1.SelectCommand = sc;

            ASPxGridView1.DataBind();
        }


        protected void ASPxButton1_Click1(object sender, EventArgs e)
        {
            //Chax();
        }

        protected void ASPxButtonExport_Click(object sender, EventArgs e)
        {
            Chax();
            ASPxGridViewExporter1.WriteXlsToResponse();
        }
        protected int GetRowCounts()
        {
            int iRowCount = 0;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnString"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select count(*) from CWX_GZ", conn);
                conn.Open();

                // Execute the SqlCommand and get the row counts.
                iRowCount = (int)cmd.ExecuteScalar();
            }

            return iRowCount;
        }

        // Retrieve data from the Excel spreadsheet.
        protected DataTable RetrieveData(string strConn)
        {
            DataTable dtExcel = new DataTable();

            using (OleDbConnection conn = new OleDbConnection(strConn))
            {
                conn.Open();
                DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                string sheetName = schemaTable.Rows[0][2].ToString().Trim();

                // Initialize an OleDbDataAdapter object.
                OleDbDataAdapter da = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);

                // Fill the DataTable with data from the Excel spreadsheet.
                da.Fill(dtExcel);
                conn.Close();
            }

            return dtExcel;
        }

        // Import the data from DataTable to SQL Server via SqlBulkCopy
        protected void SqlBulkCopyImport(DataTable dtExcel)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnString"].ToString()))
            {
                // Open the connection.
                conn.Open();

                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
                {
                    // Specify the destination table name.
                    bulkCopy.DestinationTableName = "dbo.CWX_GZ";

                    foreach (DataColumn dc in dtExcel.Columns)
                    {
                        // Because the number of the test Excel columns is not 
                        // equal to the number of table columns, we need to map 
                        // columns.
                        bulkCopy.ColumnMappings.Add(dc.ColumnName, dc.ColumnName);
                    }

                    //bulkCopy.ColumnMappings.Add("签字", "时间");
                    // Write from the source to the destination.
                    bulkCopy.WriteToServer(dtExcel);
                }
            }
        }
        protected void ASPxButtonImport_Click(object sender, EventArgs e)
        {
            // Before attempting to import the file, verify
            // that the FileUpload control contains a file.
            if (fupExcel.UploadedFiles[0].IsValid)
            {
                // Get the name of the Excel spreadsheet to upload.
                string strFileName = Server.HtmlEncode(fupExcel.UploadedFiles[0].FileName);

                // Get the extension of the Excel spreadsheet.
                string strExtension = Path.GetExtension(strFileName);

                // Validate the file extension.
                if (strExtension != ".xls" && strExtension != ".xlsx")
                {
                    Response.Write("<script>alert('请选择一个Excel文件(.xls)!');</script>");
                    return;
                }

                // Generate the file name to save.
                string strUploadFileName = "~/" + DateTime.Now.ToString("yyyyMMddHHmmss") + strExtension;

                // Save the Excel spreadsheet on server.
                fupExcel.UploadedFiles[0].SaveAs(Server.MapPath(strUploadFileName));

                // Generate the connection string for Excel file.
                string strExcelConn = "";

                // There is no column name In a Excel spreadsheet. 
                // So we specify "HDR=YES" in the connection string to use 
                // the values in the first row as column names. 
                if (strExtension == ".xls")
                {
                    // Excel 97-2003
                    strExcelConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath(strUploadFileName) + ";Extended Properties='Excel 8.0;HDR=YES;'";
                }
                else
                {
                    // Excel 2007
                    strExcelConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath(strUploadFileName) + ";Extended Properties='Excel 12.0 Xml;HDR=YES;'";
                }

                DataTable dtExcel = RetrieveData(strExcelConn);

                // Get the row counts before importing.
                int iStartCount = GetRowCounts();

                // Import the data.
                SqlBulkCopyImport(dtExcel);

                // Get the row counts after importing.
                int iEndCount = GetRowCounts();

                // Display the number of imported rows. 
                lblMessages.Text = Convert.ToString(iEndCount - iStartCount) + "条记录被导入成功";
                // Remove the uploaded Excel spreadsheet from server.
                File.Delete(Server.MapPath(strUploadFileName));
            }
        }

        protected void ASPxButtonClear_Click(object sender, EventArgs e)
        {
            SqlDataSource1.DeleteParameters[0].DefaultValue = ASPxDateEdit1.DateTime.ToString("yyyyMM");
            int affectedRows = SqlDataSource1.Delete();
            lblMessages.Text = ASPxDateEdit1.DateTime.ToString("yyyy年MM月工资：") + Convert.ToString(affectedRows) + "条记录被清除";
            Project.Common.LogHelper.WriteLog(GetType(), loginUser.UserId + ":" + lblMessages.Text);
        }
    }
}