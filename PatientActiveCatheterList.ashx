<%@ WebHandler Language="C#" Class="PatientActiveCatheterList" %>

using System;
using System.Web;


using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

using Newtonsoft.Json;








public class PatientActiveCatheterList : System.Web.IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        context.Response.Write("");


        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        string patientactivecatheterid = "5";
        string spare = "";
        string connstring = "server=210.17.120.51;user id=sa;password=aug@0815;database=imedtac_new2;";
        HISService.HISServiceSoapClient hisgpac = new HISService.HISServiceSoapClient();
        String ntuGPAC = hisgpac.GetPatientActiveCatheterList("1", "2", "3");
        dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(ntuGPAC);


        string json = Convert.ToString(data.data);
        System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
        foreach (Newtonsoft.Json.Linq.JObject o in data.data)
        {
            Patient p = new Patient();


            //var connstring = ConfigurationManager.ConnectionStrings["imedtac_new2"].ConnectionString;
            string queryString = "INSERT INTO ntu_PatientActiveCatheter (patientinfoid,insertcathdate,planremovecathdate,cathtertypename,cathtertypecode,cathtertypenumber,cathterspecialInstruction,dataupdatetime,spare)VALUES ('" +
            patientactivecatheterid + "','" + (string)o["InsertCathDate"] + "','" + (string)o["PlanRemoveCathDate"] + "','"
            + (string)o["CathterTypeName"] + "','" + (string)o["CathterTypeCode"] + "','" + (string)o["CathterTypeNumber"] + "','"
            + (string)o["CathterSpecialInstruction"] + "','"
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





        public string InsertCathDate { get; set; }
        public string PlanRemoveCathDate { get; set; }
        public string CathterTypeName { get; set; }
        public string CathterTypeCode { get; set; }

        public string CathterTypeNumber { get; set; }
        public string CathterSpecialInstruction { get; set; }


















    }

}