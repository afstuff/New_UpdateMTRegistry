﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UpdateNIID.Data;

namespace UpdateNIID.Web
{
    public partial class Default2 : System.Web.UI.Page
    {
        MotorDetailsRepository motorsRepo = new MotorDetailsRepository();
        private DataTable _dt = null;
        private string _startDate;
        private string _endDate;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                //check connection

                int r = motorsRepo.NetworkStatus();
                if (r == 0)
                {
                    onlineLbl.Text = "Offline";
                    statusImg.ImageUrl = "~/Images/redlight.fw.png";
                    statusImg.Height = 60;
                }
                else
                {
                    onlineLbl.Text = "Online";
                    statusImg.ImageUrl = "~/Images/greenlight.fw.png";
                    statusImg.Height = 60;
                }

                GetVehicleDateailsAll();


            }


        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (txtStartDate.Text != "" && txtEndDate.Text != "" && txtSvalue.Text != "")
            {
                GetVehicleDateails(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text), Convert.ToInt16(filterDdw.SelectedValue), txtSvalue.Text);
            }
            else
            {
                GetVehicleDateailsAll();
                this.DataBind();
            }
        }

        protected void DoSearch(object sender, EventArgs e)
        {


            if (Convert.ToInt16(filterDdw.SelectedValue) == 0 && txtSvalue.Text == "")
            {
                txtSvalue.Text = "*";
            }

            if (txtStartDate.Text == "" || txtEndDate.Text == "")
            {
                txtStartDate.Text = "01/01/1900";
                txtEndDate.Text = "01/01/3000";
            }
           
            if (txtSvalue.Text == "")
            {
                txtSvalue.Text = "*";
            }

            if (txtStartDate.Text != "" && txtEndDate.Text != "" && txtSvalue.Text != "")
            {
                _dt = new DataTable();
                _dt = motorsRepo.GetMotorDetailsDt(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text), Convert.ToInt16(filterDdw.SelectedValue), txtSvalue.Text);
                if (_dt != null)
                {
                    //count posted and uploaded records
                    DoCount(_dt);
                    GridView1.DataSource = null;
                    GridView1.DataSource = _dt;
                    GridView1.DataBind();
                }

                //txtStartDate.Text = "";
                //txtEndDate.Text = "";
            }
        }

        //count posted and uploaded records
        public void DoCount(DataTable dt)
        {
            int cU = 0;
            int cP = 0;
            if (dt != null)
            {
                cP = _dt.Rows.Count;
                lblPosted.Text = cP.ToString();
                foreach (DataRow row in _dt.Rows)
                {
                    var cUText = row["NIID_Status"].ToString();
                    if (cUText == "P")
                    {
                        cU++;
                    }
                }
                lblUploaded.Text = cU.ToString();
            }
        }

        public string CheckDate(string dDate)
        {
            if (dDate == null)
            {
                return "Date field cannot be empty!";
            }

            DateTime? newDate = null;
            string[] dateString = dDate.Split(new Char[] { '/' });
            newDate = Convert.ToDateTime(dateString[2] + "-" + dateString[1] + "-" + dateString[0]);
            return newDate.ToString();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            // GridView1.DataBind();
            if (txtStartDate.Text != "" && txtEndDate.Text != "" && txtSvalue.Text != "")
            {
                GetVehicleDateails(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text), Convert.ToInt16(filterDdw.SelectedValue), txtSvalue.Text);
            }
            else
            {
                GetVehicleDateailsAll();
            }
        }

        protected void GetVehicleDateails(string sDate, string eDate, int filter, string sValue)
        {
            _dt = new DataTable();
            _dt = motorsRepo.GetMotorDetailsDt(sDate, eDate, filter, sValue);


            if (_dt != null)
            {
                DoCount(_dt);
                GridView1.DataSource = _dt;
                GridView1.DataBind();
                //GridView1.Columns[1].Visible = false;
            }
        }

        protected void GetVehicleDateailsAll()
        {
            _dt = new DataTable();
            _dt = motorsRepo.GetMotorDetailsAllDt();

            if (_dt != null)
            {
                //count posted and uploaded
                DoCount(_dt);
                GridView1.DataSource = _dt;
                GridView1.DataBind();
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox cbx = GridView1.Rows[i].Cells[1].FindControl("chkSel") as CheckBox;
                var vr = GridView1.Rows[i].Cells[8].Text;
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

        protected void DoUpdate(object sender, EventArgs e)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox cbx = GridView1.Rows[i].Cells[1].FindControl("chkSel") as CheckBox;

                HiddenField hd = GridView1.Rows[i].FindControl("Id_No") as HiddenField;
                //var rVal = GridView1.Rows[i].Cells[1].Text;
                var rVal = Convert.ToInt16(hd.Value.ToString());
                if (cbx.Enabled && !cbx.Checked)
                {
                    //update db
                    motorsRepo.Update(rVal);
                }

                if (cbx.Enabled && cbx.Checked)
                {
                    //update db
                    motorsRepo.Update1(rVal);
                }
            }

            if (txtStartDate.Text != "" && txtEndDate.Text != "")
            {
                GetVehicleDateails(CheckDate(txtStartDate.Text), CheckDate(txtEndDate.Text), Convert.ToInt16(filterDdw.SelectedValue), txtSvalue.Text);
            }
            else
            {
                GetVehicleDateailsAll();
            }
        }
    }
}