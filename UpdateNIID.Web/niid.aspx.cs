using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using UpdateNIID.Data;
using UpdateNIID.Model;

namespace UpdateNIID.Web
{
    public partial class niid : System.Web.UI.Page
    {
        MotorDetailsRepository _mRepository = new MotorDetailsRepository();
        public DataTable Dt = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //check connection

                int r = _mRepository.NetworkStatus();
                if (r == 0)
                {
                    onlineLbl.Text = "Offline";
                    statusImg.ImageUrl = "~/Images/redlight.fw.png";
                }
                else
                {
                    onlineLbl.Text = "Online";
                    statusImg.ImageUrl = "~/Images/greenlight.fw.png";
                }

                var today = DateTime.Now.Date.ToString("yyyy-mm-dd");
                GetVehicleDateails(today, today);

            }
        }


        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            //GridView2.DataBind();
            Dt = new DataTable();
            Dt = _mRepository.GetMotorDetailsDt(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text));

        }


        //protected void Timer1_Tick(object sender, EventArgs e)
        //{
        //    if (txtStartDate.Text != "" && txtEndDate.Text != "")
        //    {
        //        GetVehicleDateails(txtStartDate.Text.ToString(), txtEndDate.Text.ToString());
        //    }
        //    else
        //    {
        //        var today = DateTime.Now.Date.ToString("yyyy-mm-dd");
        //        GetVehicleDateails(today, today);

        //    }
        //}


        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox cbx = GridView2.Rows[i].Cells[1].FindControl("chkSel") as CheckBox;
                var vr = GridView2.Rows[i].Cells[8].Text;
                if (vr == "P")
                {
                    cbx.Checked = true;
                    cbx.Enabled = false;
                }

                if (vr == "A")
                {
                    cbx.Checked = true;
                    //cbx.Enabled = false;
                }

            }
        }


        protected void GetVehicleDateails(string sDate, string eDate)
        {
            Dt = new DataTable();
            Dt = _mRepository.GetMotorDetailsDt(sDate, eDate);

            int cU = 0;
            int cP = 0;

            if (Dt != null)
            {
                cP = Dt.Rows.Count;
                lblPosted.Text = cP.ToString();
                foreach (DataRow row in Dt.Rows)
                {
                    var cUText = row["NIID_Status"];
                    if (cUText == "P")
                    {
                        cU++;
                    }
                }
                lblUploaded.Text = cU.ToString();

                GridView2.DataSource = Dt;
                GridView2.DataBind();
            }
        }

      

        protected void DoSearch(object sender, EventArgs e)
        {
            if (txtStartDate.Text != "" && txtEndDate.Text != "")
            {
                Dt=new DataTable();
                Dt = _mRepository.GetMotorDetailsDt(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text));

                int cU = 0;
                int cP = 0;
                if (Dt != null)
                {
                    cP = Dt.Rows.Count;
                    lblPosted.Text = cP.ToString();
                    foreach (DataRow row in Dt.Rows)
                    {
                        var cUText = row["NIID_Status"].ToString();
                        if (cUText == "P")
                        {
                            cU++;
                        }
                    }
                    lblUploaded.Text = cU.ToString();


                    GridView2.DataSource = Dt;
                    GridView2.DataBind();
                }
            }
        }


        protected void DoUpdate(object sender, EventArgs e)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox cbx = GridView2.Rows[i].Cells[1].FindControl("chkSel") as CheckBox;
                var rVal = GridView2.Rows[i].Cells[1].Text;
                if (!cbx.Checked)
                {
                    //update db
                    _mRepository.Update(rVal);
                }
            }


        }


        public string CheckDate(string dDate)
        {
            DateTime? newDate = null;
            string[] dateString = dDate.Split(new Char[] { '/' });
            newDate = Convert.ToDateTime(dateString[2] + "-" + dateString[1] + "-" + dateString[0]);
           return newDate.ToString();
        }

    }
}