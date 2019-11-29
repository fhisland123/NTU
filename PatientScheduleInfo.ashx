<%@ WebHandler Language="C#" Class="PatientScheduleInfo" %>

using System;
using System.Web;


using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

using Newtonsoft.Json;








public class PatientScheduleInfo : System.Web.IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write("");


        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        string patientscheduleid = "5";
        string spare = "";
        string connstring = "server=210.17.120.51;user id=sa;password=aug@0815;database=imedtac_new2;";
        HISService.HISServiceSoapClient hisgpac = new HISService.HISServiceSoapClient();
        String ntuGPAC = hisgpac.GetPatientScheduleInfo("1", "2", "3");
        dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(ntuGPAC);


        string json = Convert.ToString(data.data);
        System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
        foreach (Newtonsoft.Json.Linq.JObject o in data.data)
        {
            Patient p = new Patient();


            //var connstring = ConfigurationManager.ConnectionStrings["imedtac_new2"].ConnectionString;
            string queryString = "INSERT INTO ntu_PatientSchedule (patientinfoid,accountid,grouptype,schedulename,scheduledate,scheduledatedisplayInfo,dataupdatetime,spare)VALUES ('" +
            patientscheduleid + "','" + (string)o["AccountID"] + "','" + (string)o["GroupType"] + "','"
            + (string)o["ScheduleName"] + "','" + (string)o["ScheduleDate"] + "','"
            + (string)o["ScheduleDateDisplayInfo"] + "','"
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





        public string AccountID { get; set; }
        public string GroupType { get; set; }
        public string ScheduleName { get; set; }
        public string ScheduleDate { get; set; }

        public string ScheduleDateDisplayInfo { get; set; }
       


















    }

}