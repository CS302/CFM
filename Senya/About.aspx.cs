using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Senya
{
    public partial class About : Page
    {
        private static string connectionstring = @"Data Source=.\SQLEXPRESS;Initial Catalog=CFM;Integrated Security=True";
        private Random rnd;
        private const int count = 10;
        private TextBox[] tbs;

        public static List<double> values;
        protected void Page_Load(object sender, EventArgs e)
        {
            //_BTN_Start.Click += new EventHandler(this._BTN_Start_Click);
            _LBL_results.Visible = true;
            _LBL_res.Visible = false;
            rnd = new Random();
            tbs = new TextBox[count] { _TB_m1, _TB_m2, _TB_m3, _TB_m4, _TB_m5, _TB_m6, _TB_m7, _TB_m8, _TB_m9, _TB_m10 };
            _TB_pID.MaxLength = 6;
        }

        private double GetData()
        {
            return Math.Round(rnd.NextDouble() * (45.6 - 45.4) + 45.4, 1);
        }

        private double GetNormal(int Pat_id)
        {
            values = new List<double>();
            //заполнение из БД
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command = new SqlCommand("dbo.cfm_read_measures", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("Pat_id", Pat_id);
                connection.Open();
                SqlDataReader Reader = command.ExecuteReader();
                while (Reader.Read())
                    values.Add(double.Parse(Reader["crit_f"].ToString()));
                Reader.Close();
                connection.Close();
            }
            
            Dictionary<double, int> dict = new Dictionary<double, int>();
            
            foreach (var item in values)
            {
                if (!dict.ContainsKey(item))
                    dict.Add(item, 1);
                else
                    dict[item] += 1;
            }

            int max = 0;
            double normal = 0;
            foreach (var item in dict)
                if (item.Value > max)
                {
                    max = item.Value;
                    normal = item.Key;
                }
            
            return normal;
        }

        private double GetStdDev(double[] mes)
        {
            double sum = 0.0;
            double normal = GetNormal(int.Parse(_TB_pID.Text));
            for (int i = 0; i < mes.Length; i++)
                sum += Math.Pow((mes[i] - normal), 2);
            sum /= (mes.Length - 1);
            return Math.Round(Math.Sqrt(sum), 2);
        }

        private double GetEv(double[] mes)
        {
            double sum = 0.0;
            for (int i = 0; i < mes.Length; i++)
                sum += mes[i];
            sum /= mes.Length;
            return sum;
        }

        protected void _BTN_Start_Click(object sender, EventArgs e)
        {
            _LBL_results.Visible = false;
            _LBL_res.Visible = true;
            double[] values = new double[count];
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command;
                for (int i = 0; i < count; i++)
                {
                    values[i] = GetData();
                    tbs[i].Text = values[i].ToString();
                    
                    //сохранить результаты в БД

                    command = new SqlCommand("dbo.cfm_insert_measure", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("Pat_id", int.Parse(_TB_pID.Text));
                    command.Parameters.AddWithValue("Doc_id", int.Parse(Context.Request.Cookies["doc_id"].Value));
                    command.Parameters.AddWithValue("Mes", values[i]);
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            
            _TB_ev.Text = GetEv(values).ToString();
            _TB_sd.Text = GetStdDev(values).ToString();
            _TB_ev_ok.Text = GetNormal(int.Parse(_TB_pID.Text)).ToString();
            _TB_sd_ok.Text = Math.Truncate(double.Parse(_TB_sd.Text) / double.Parse(_TB_ev_ok.Text) * 100).ToString() + " %";
            if (double.Parse(_TB_sd_ok.Text.Split(' ')[0]) < 2)
            {
                _LBL_res.Text = "Обледование завершено.\nДопустить пилота к управлению воздушным судном.";
            }
            else
            {
                _LBL_res.Text = "Обледование завершено.\nНе допускать пилота к управлению воздушным судном.";
            }
        }

        protected void _BTN_ok_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command = new SqlCommand("dbo.cfm_read_personal", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("Pat_id", int.Parse(_TB_pID.Text));
                connection.Open();
                SqlDataReader Reader = command.ExecuteReader();
                if (Reader.Read())
                {
                    _TB_Name.Text = Reader["name"].ToString();
                    _TB_Surname.Text = Reader["surname"].ToString();
                    _TB_Company.Text = Reader["c_name"].ToString();
                    _TB_Position.Text = Reader["p_name"].ToString();
                }
                Reader.Close();
                connection.Close();

                Context.Response.Cookies.Add(new HttpCookie("pat_id", _TB_pID.Text));
            }
        }        
    }
}