using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Net;

namespace Senya.Account
{
    public partial class Login : Page
    {
        private static string connectionstring = @"Data Source=.\SQLEXPRESS;Initial Catalog=CFM;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            RegisterHyperLink.NavigateUrl = "Register";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];

            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
            
            
        }

        private string GetHashedPassword(string pswrd)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            return Encoding.Default.GetString(md5.ComputeHash(Encoding.Default.GetBytes(pswrd)));
        }

        protected void _btn_Login_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand command = new SqlCommand("dbo.cfm_login", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("Login", _login.UserName);
                command.Parameters.AddWithValue("Password", GetHashedPassword(_login.Password));
                connection.Open();
                SqlDataReader Reader = command.ExecuteReader();
                if (Reader.Read())
                {
                    Context.Response.Cookies.Add(new HttpCookie("doc_id", Reader["id"].ToString()));
                    FormsAuthentication.RedirectFromLoginPage(_login.UserName, true);
                }
                Reader.Close();
            }
        }
    }
}