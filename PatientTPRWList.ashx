<%@ WebHandler Language="C#" Class="PatientTPRWList" %>

using System;
using System.Web;


using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

using Newtonsoft.Json;








public class PatientTPRWList : System.Web.IHttpHandler
{


    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write("");


        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        string patienttprwid = "5";
        string spare = "";
        string connstring = "server=210.17.120.51;user id=sa;password=aug@0815;database=imedtac_new2;";
        HISService.HISServiceSoapClient hisgpac = new HISService.HISServiceSoapClient();
        String ntuGPAC = hisgpac.GetPatientTPRWList("1", "2", "3","4");
        dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(ntuGPAC);


        string json = Convert.ToString(data.data);
        System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
        foreach (Newtonsoft.Json.Linq.JObject o in data.data)
        {
            Patient p = new Patient();


            //var connstring = ConfigurationManager.ConnectionStrings["imedtac_new2"].ConnectionString;
            string queryString = "INSERT INTO ntu_PatientTPRW (patientinfoid,date,tmax,tmin,pmax,pmin,rmax,rmin,wmax,wmin,dataupdatetime,spare)VALUES ('" +
            patienttprwid + "','" + (string)o["Date"] + "','" + (string)o["TMax"] + "','"
            + (string)o["TMin"] + "','" + (string)o["PMax"] + "','" + (string)o["PMin"] + "','"
            + (string)o["RMax"] + "','" + (string)o["RMin"] + "','" + (string)o["WMax"] + "','"
            + (string)o["WMin"] + "','"
            + currentTime.ToString("yyyy-MM-dd HH:mm:ss") + "','" + spare + "')";

            context.Response.Write(queryString);
            SqlConnection conn = new SqlConnection(connstring);
            conn.Open();
            SqlCommand command = new SqlCommand(queryString, conn);
            context.Response.Write("AAA" + conn);
            command.ExecuteNonQuery();
            conn.Close();
        }
        // System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
        //Patient patient = JsonConvert.DeserializeObject<Patient>(json);


        context.Response.Write(json + "------" + Convert.ToString(data));










    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public class Patient
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public bool IsManager { get; set; }
        public DateTime JoinedDate { get; set; }
        public System.Collections.Generic.IList<string> Data { get; set; }




        public string Total { get; set; }





        public string Date { get; set; }
        public string TMax { get; set; }
        public string TMin { get; set; }
        public string PMax { get; set; }

        public string PMin { get; set; }
        public string RMax { get; set; }
        public string RMin { get; set; }
        public string WMax { get; set; }
        public string WMin { get; set; }
   


















    }

}