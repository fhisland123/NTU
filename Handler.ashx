<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;


using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

using Newtonsoft.Json;








public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("");


        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        string patientinfoid = "5";
        string spare = "";
        string connstring = "server=210.17.120.51;user id=sa;password=aug@0815;database=imedtac_new2;";
        HISService.HISServiceSoapClient hisgpac = new HISService.HISServiceSoapClient();
        String ntuGPAC = hisgpac.GetPatientInfoListEx("1", "2", "3","2","8");
        dynamic data = Newtonsoft.Json.JsonConvert.DeserializeObject(ntuGPAC);


        string json = Convert.ToString(data.data);
        System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
        foreach (Newtonsoft.Json.Linq.JObject o in data.data)
        {
            Patient p = new Patient();
        

            //var connstring = ConfigurationManager.ConnectionStrings["imedtac_new2"].ConnectionString;
            string queryString = "INSERT INTO ntu_PatientInfo (patientinfoid,DeptCode,BedIDSE,PatientName,SexInfo,AgeInfo,BloodInfo,LanguageInfo,InDate ,OPDate,NoteList,ProhibitionTreatment,VSName,VSEmpNo,RSOrNPName,RSOrNPEmpNo,RSOrNPType,NurseName,NurseEmpNo,AccountID,ChartNo,OutDate,BirthDate,AllergyInfo,NurseEngName,dataupdatetime,spare)VALUES ('" +
            patientinfoid + "','" + (string)o["DeptCode"] + "','" + (string)o["BedIDSE"] + "','" + (string)o["PatientName"]
            + "','" + (string)o["SexInfo"] + "','" + (string)o["AgeInfo"] + "','" + (string)o["BloodInfo"] + "','" + (string)o["LanguageInfo"]
            + "','" + (string)o["InDate"] + "','" + (string)o["OPDate"] + "','" + (string)o["NoteList"] + "','"
            + (string)o["ProhibitionTreatment"] + "','" + (string)o["VSName"] + "','" + (string)o["VSEmpNo"] + "','" + (string)o["RSOrNPName"] + "','" + (string)o["RSOrNPEmpNo"]
            + "','" + (string)o["RSOrNPType"] + "','" + (string)o["NurseName"] + "','" + (string)o["NurseEmpNo"] + "','" + (string)o["AccountID"] + "','" + (string)o["ChartNo"] + "','" + (string)o["OutDate"] + "','"
            + (string)o["BirthDate"] + "','" + (string)o["AllergyInfo"] + "','" + (string)o["NurseEngName"] + "','" +
             currentTime.ToString("yyyy-MM-dd HH:mm:ss") + "','" + spare + "')";
        
            context.Response.Write(queryString);
            SqlConnection conn = new SqlConnection(connstring);
            conn.Open();
            SqlCommand command = new SqlCommand(queryString, conn);
            context.Response.Write("AAA" + conn);
            //command.ExecuteNonQuery();
            conn.Close();
        }
        // System.Collections.Generic.List<Patient> p_info_list = new System.Collections.Generic.List<Patient>();
      //Patient patient = JsonConvert.DeserializeObject<Patient>(json);


        context.Response.Write(json + "------" + Convert.ToString(data));

         
        
      

        
        
        
        
        
    }
 
    public bool IsReusable {
        get {
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





        public string DeptCode { get; set; }
        public string BedIDSE { get; set; }
        public string PatientName { get; set; }
        public string SexInfo { get; set; }

        public string AgeInfo { get; set; }
        public string BloodInfo { get; set; }
        public string LanguageInfo { get; set; }
        public string InDate { get; set; }

        public string OPDate { get; set; }
        public string NoteList { get; set; }
        public string ProhibitionTreatment { get; set; }
        public string VSName { get; set; }

        public string VSEmpNo { get; set; }
        public string RSOrNPName { get; set; }
        public string RSOrNPEmpNo { get; set; }
        public string RSOrNPType { get; set; }

        public string NurseName { get; set; }
        public string NurseEmpNo { get; set; }
        public string AccountID { get; set; }
        public string ChartNo { get; set; }

        public string OutDate { get; set; }
        public string BirthDate { get; set; }
        public string AllergyInfo { get; set; }
        public string NurseEngName { get; set; }


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      
    }
}