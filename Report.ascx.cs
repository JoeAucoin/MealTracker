using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Framework.JavaScriptLibraries;
using GIBS.Modules.MealTracker.Components;
using DotNetNuke.Common;
using System.Web.UI.HtmlControls;
using DotNetNuke.Entities.Users;

namespace GIBS.Modules.MealTracker
{
    public partial class Report : MealTrackerModuleBase
    {

        int childtotal = 0;
        int adulttotal = 0;
        int headcounttotal = 0;
        int platetotal = 0;


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
                //DateTime dt = DateTime.Now;
                //dt.Subtract(
                txtStartDate.Text = DateTime.Now.AddMonths(-1).ToShortDateString();
                txtEndDate.Text = DateTime.Today.ToShortDateString();

                FillGrid();
                

                
            }
        }

        public void FillGrid()
        {

            try
            {

                GridViewSummaryReport.DataSource = MealController.Report(this.ModuleId, txtStartDate.Text.ToString(), txtEndDate.Text.ToString());
                GridViewSummaryReport.DataBind();

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

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
                    childtotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ChildCount"));
                    headcounttotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "HeadCount"));
                    adulttotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "AdultCount"));
                    platetotal += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PlatesServed"));
                    //  grdTotal = grdTotal + rowTotal;

                }


                if (e.Row.RowType == DataControlRowType.Footer)
                {
                    Label lbl = (Label)e.Row.FindControl("lblChildrenTotal");
                    lbl.Text = childtotal.ToString();

                    //lblAdultTotal
                    Label lblAdult = (Label)e.Row.FindControl("lblAdultTotal");
                    lblAdult.Text = adulttotal.ToString();

                    Label lblHeads = (Label)e.Row.FindControl("lblHeadTotal");
                    lblHeads.Text = headcounttotal.ToString();

                    
                    Label lblPlates = (Label)e.Row.FindControl("lblPlatesServedTotal");
                    lblPlates.Text = platetotal.ToString();
                }

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
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