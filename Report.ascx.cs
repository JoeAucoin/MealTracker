/*
' Copyright (c) 2023  GIBS.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Framework.JavaScriptLibraries;
using GIBS.Modules.MealTracker.Components;
using DotNetNuke.Common;
using System.Web.UI.HtmlControls;
using DotNetNuke.Entities.Users;
using DotNetNuke.Common.Lists;

namespace GIBS.Modules.MealTracker
{
    public partial class Report : MealTrackerModuleBase
    {

        int firststotal = 0;
        int secondstotal = 0;
        int headcounttotal = 0;
        int deliveredtotal = 0;
        int servicedaystotal = 0;
        int adulttotal = 0;
        int leftoverstotal = 0;
        int shorttotal = 0;

        private GridViewHelper helper;
        // To show custom operations...
        private List<int> mQuantities = new List<int>();



        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            JavaScript.RequestRegistration(CommonJs.jQuery);
            JavaScript.RequestRegistration(CommonJs.jQueryUI);

            // ADD STYLESHEET FROM SETTINGS
            HtmlGenericControl css1 = new HtmlGenericControl("link");
            css1.Attributes["type"] = "text/css";
            if (Settings.Contains("jQueryUI"))
            {
                css1.Attributes["href"] = Settings["jQueryUI"].ToString();
            }
            else
            {
                css1.Attributes["href"] = "https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/redmond/jquery-ui.css";
            }
            css1.Attributes["rel"] = "stylesheet";
            css1.Attributes["media"] = "screen";
            Page.Header.Controls.Add(css1);

            //    Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "InputMasks", (this.TemplateSourceDirectory + "/JavaScript/jquery.maskedinput-1.3.js"));
            //    Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "Watermark", (this.TemplateSourceDirectory + "/JavaScript/jquery.watermarkinput.js"));


        }


        protected void Page_Load(object sender, EventArgs e)
        {



            if (!IsPostBack)
            {
                GetDropDownLists();
                //DateTime dt = DateTime.Now;
                //dt.Subtract(
                txtStartDate.Text = DateTime.Now.AddMonths(-1).ToShortDateString();
                txtEndDate.Text = DateTime.Today.ToShortDateString();

                GroupIt();
                FillGrid();
                

                
            }
        }

        public void FillGrid()
        {

            try
            {

                GridViewSummaryReport.DataSource = MealController.ReportSummary(ddlLocationID.SelectedValue.ToString(), txtStartDate.Text.ToString(), txtEndDate.Text.ToString(), this.PortalId, ddlTowns.SelectedValue.ToString(), ddlLocationCode.SelectedValue.ToString());
                GridViewSummaryReport.DataBind();

                gv_Report.DataSource = MealController.Report(ddlLocationID.SelectedValue.ToString(), txtStartDate.Text.ToString(), txtEndDate.Text.ToString(), this.PortalId, ddlTowns.SelectedValue.ToString(), ddlLocationCode.SelectedValue.ToString());
                gv_Report.DataBind();

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public void GetDropDownLists()

        {

            try
            {
               
                List<MealInfo> items;
              //  MealController controller = new MealController();
                
                items = MealController.GetLocations("");

                ddlLocationID.DataTextField = "Location";
                ddlLocationID.DataValueField = "LocationID";
                ddlLocationID.DataSource = items;
                ddlLocationID.DataBind();
                ddlLocationID.Items.Insert(0, new ListItem("-- Search All Programs --", "0"));
                //  ddlLocationID.SelectedValue = "MA";

                //ddlTowns
                List<MealInfo> towns;
                towns = MealController.GetLocationTowns("");

                ddlTowns.DataTextField = "City";
                ddlTowns.DataValueField = "City";
                ddlTowns.DataSource = towns;
                ddlTowns.DataBind();
                ddlTowns.Items.Insert(0, new ListItem("-- Search All Towns --", "0"));

                List<MealInfo> locationcodes;
                locationcodes = MealController.GetLocationCodeSearchNames();
                ddlLocationCode.DataTextField = "LocationCodeSearchName";
                ddlLocationCode.DataValueField = "LocationCode";
                ddlLocationCode.DataSource = locationcodes;
                ddlLocationCode.DataBind();
                ddlLocationCode.Items.Insert(0, new ListItem("-- Search All Codes --", "0"));

            }

            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }



        protected void gv_Report_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void gv_Report_DataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    var hyperLink = e.Row.FindControl("HyperLink1") as HyperLink;
            //    if (hyperLink != null)
            //    {
            //        string newURL = Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "EditCheckInOut", "mid=" + ModuleId.ToString(), "ttid=" + DataBinder.Eval(e.Row.DataItem, "TimeTrackerID"));
            //        hyperLink.NavigateUrl = newURL.ToString();
            //    }


            //    if (e.Row.Cells[6].Text.Contains("12:00 AM"))
            //    {
            //        e.Row.Cells[6].Text = "Not Checked Out";
            //        e.Row.Cells[6].BackColor = System.Drawing.Color.LightPink;

            //    }
            //}
        }

        public void GroupIt()
        {

            try
            {

                GridViewHelper helper = new GridViewHelper(this.gv_Report);
                              
                
                helper.RegisterGroup("Location", true, true);
                //helper.RegisterGroup("MonthYear", true, true);
               // helper.RegisterGroup("Seating", true, true);
              
                helper.RegisterSummary("DeliveredCount", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("FirstsCount", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("SecondsCount", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("TotalMealsCount", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("Adults", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("LeftOvers", SummaryOperation.Sum, "Location");
                helper.RegisterSummary("Short", SummaryOperation.Sum, "Location");


                //  helper.RegisterSummary("LocationID", SummaryOperation.Count);
                helper.RegisterSummary("DeliveredCount", SummaryOperation.Sum);
                helper.RegisterSummary("FirstsCount", SummaryOperation.Sum);
                helper.RegisterSummary("SecondsCount", SummaryOperation.Sum);
                helper.RegisterSummary("TotalMealsCount", SummaryOperation.Sum);
                helper.RegisterSummary("Adults", SummaryOperation.Sum);
                helper.RegisterSummary("LeftOvers", SummaryOperation.Sum);
                helper.RegisterSummary("Short", SummaryOperation.Sum);

                //// helper.RegisterGroup("ClientZipCode", true, true);
                //helper.GroupHeader += new GroupEvent(helper_GroupHeader);
                //helper.GroupSummary += new GroupEvent(helper_Bug);
                //helper.GeneralSummary += new FooterEvent(helper_GeneralSummary);
                helper.ApplyGroupSort();



            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        void helper_GeneralSummary(GridViewRow row)
        {

            row.Cells[0].HorizontalAlign = HorizontalAlign.Right;

            row.Cells[0].Text = "Grand Totals: ";
            row.BackColor = Color.BlanchedAlmond;
            row.ForeColor = Color.Black;

        }

        private void helper_Bug(string groupName, object[] values, GridViewRow row)
        {
            //if (groupName == null) return;

            //DateTime dt;
            //dt = Convert.ToDateTime(values[0]);

            //row.BackColor = Color.Lavender;
            //row.Cells[0].HorizontalAlign = HorizontalAlign.Right;
        //    row.Cells[0].Text = dt.DayOfWeek.ToString() + " - " + Convert.ToDateTime(values[0]).ToShortDateString() + " Totals&nbsp;";
        }

        private void helper_ManualSummary(GridViewRow row)
        {
            GridViewRow newRow = helper.InsertGridRow(row);
            newRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
          //  newRow.Cells[0].Text = String.Format("Total: {0} items, ", helper.GeneralSummaries["TotalTime"].Value, helper.GeneralSummaries["Location"].Value);
        }



        private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            //if (groupName == "MealDate")
            //{
            //    DateTime dt;
            //    dt = Convert.ToDateTime(row.Cells[0].Text);
            //    row.BackColor = Color.LightGray;
            //    row.Cells[0].Text = "&nbsp;&nbsp;<b>" + dt.DayOfWeek.ToString() + " - " + Convert.ToDateTime(row.Cells[0].Text).ToShortDateString() + "</b>";


            //}
            //else if (groupName == "Location")
            //{
            //    row.BackColor = Color.FromArgb(236, 236, 236);
            //    row.Cells[0].Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + row.Cells[0].Text;
            //}
        }


        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                e.Cancel = true;


            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }


        }
        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            try
            {

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    firststotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "FirstsCount"));
                    headcounttotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalMealsCount"));
                    secondstotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "SecondsCount"));
                    deliveredtotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "DeliveredCount"));
                    servicedaystotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ServiceDays"));
                    adulttotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Adults"));

                    leftoverstotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "LeftOvers"));
                    shorttotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Short"));


                }


                if (e.Row.RowType == DataControlRowType.Footer)
                {
                    Label lbl = (Label)e.Row.FindControl("lblFirstsTotal");
                    lbl.Text = firststotal.ToString();

                    Label lblSeconds = (Label)e.Row.FindControl("lblSecondsTotal");
                    lblSeconds.Text = secondstotal.ToString();

                    Label lblDelevered = (Label)e.Row.FindControl("lblDeliveredTotal");
                    lblDelevered.Text = deliveredtotal.ToString();
                    
                    Label lblPlates = (Label)e.Row.FindControl("lblTotalServedTotal");
                    lblPlates.Text = headcounttotal.ToString();

                    Label lblServiceDays = (Label)e.Row.FindControl("lblTotalServiceDays");
                    lblServiceDays.Text = servicedaystotal.ToString();

                    Label lblAdult = (Label)e.Row.FindControl("lblAdults");
                    lblAdult.Text = adulttotal.ToString();

                    Label lblShort = (Label)e.Row.FindControl("lblShort");
                    lblShort.Text = shorttotal.ToString();

                    Label lblLeftOvers = (Label)e.Row.FindControl("lblLeftOvers");
                    lblLeftOvers.Text = leftoverstotal.ToString();
                }

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            GroupIt();
            FillGrid();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect(Globals.NavigateURL(), true);
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }


    }
}