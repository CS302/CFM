using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Senya
{
    public partial class Contact : Page
    {
        private static string connectionstring = @"Data Source=.\SQLEXPRESS;Initial Catalog=CFM;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            GetInfo();
        }

        private void GetInfo()
        {
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command = new SqlCommand("dbo.cfm_read_diagnosis", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("Pat_id", int.Parse(Context.Request.Cookies["pat_id"].Value));
                connection.Open();
                SqlDataReader Reader = command.ExecuteReader();
                if (Reader.Read())
                {
                    _TB_Last.Text = Reader["diagnosis"].ToString();
                }
                Reader.Close();
                connection.Close();
            }
        }

        private void GetData()
        {
            if (!_ChB_Susp.Checked)
            {
                DateTime date1 = DateTime.Parse(_TB_FirstDate.Text);
                DateTime date2 = DateTime.Parse(_TB_SecondDate.Text);
                //запрос к таблице cure
                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    SqlCommand command = new SqlCommand("dbo.cfm_insert_cure", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("Pat_id", int.Parse(Context.Request.Cookies["pat_id"].Value));
                    command.Parameters.AddWithValue("Doc_id", int.Parse(Context.Request.Cookies["doc_id"].Value));
                    command.Parameters.AddWithValue("Date1", date1);
                    command.Parameters.AddWithValue("Date2", date2);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();

                }
            }
            //запрос к таблице diagnosis
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command = new SqlCommand("dbo.cfm_insert_diagnosis", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("Pat_id", int.Parse(Context.Request.Cookies["pat_id"].Value));
                command.Parameters.AddWithValue("Doc_id", int.Parse(Context.Request.Cookies["doc_id"].Value));
                command.Parameters.AddWithValue("Diagnosis", _TB_Current.Text);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

            }
        }

        protected void _BTN_save_Click(object sender, EventArgs e)
        {
            GetData();
        }
    }
}