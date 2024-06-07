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
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using DotNetNuke.Framework.JavaScriptLibraries;
using GIBS.Modules.MealTracker.Components;
//using GIBS.Modules.MealTracker.Data;
using DotNetNuke.Common;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using DotNetNuke.Entities.Users;
using DotNetNuke.Common.Lists;
using System.Data;
using DotNetNuke.UI.Skins;
using System.Collections.Generic;
using System.Web.UI;
using System.Linq.Expressions;

namespace GIBS.Modules.MealTracker
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from MealTrackerModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : MealTrackerModuleBase, IActionable
    {

        static string _LocationsList = "MTLocations";
        static string _SeatingList = "MTMealSeating";
        static bool _DESE_Breakfast = false;
        static bool _DESE_Lunch = false;
        static bool _DESE_Snack = false;
        static bool _DESE_Snack_PM = false;

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

            //  Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "InputMasks", (this.TemplateSourceDirectory + "/JavaScript/jquery.maskedinput-1.3.js"));
            //  Page.ClientScript.RegisterClientScriptInclude(this.GetType(), "Watermark", (this.TemplateSourceDirectory + "/JavaScript/jquery.watermarkinput.js"));

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {




                if (!IsPostBack)
                {
                    LoadSettings();

                    GridView1.DataSource = MealController.GetAllMeals(0, this.PortalId);
                    GridView1.DataBind();

                    GetDropDownLists();
                }
                //else
                //{

                //    if (!string.IsNullOrEmpty(hfSelecteValue.Value.ToString()))
                //    {
                //        ddlLocationID.ClearSelection();
                //        // ddlLocationID.Items.FindByValue(hfSelecteValue.Value.ToString()).Selected = true;
                //        ddlLocationID.SelectedValue = hfSelecteValue.Value.ToString();
                //    }

                //}

                //if (this.UserId > 1)
                //{
                //    DotNetNuke.Security.Roles.RoleController rolesController = new DotNetNuke.Security.Roles.RoleController();
                //    UserRoleInfo role = rolesController.GetUserRole(0, this.UserId, rolesController.GetRoleByName(0, "Donor").RoleID);
                //    DateTime expiryDate = role.ExpiryDate;
                //    lblDebug.Text = expiryDate.ToShortDateString();
                //}
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }


        public void FillGrid()
        {

            try
            {

                GridView1.DataSource = MealController.GetAllMeals(Int32.Parse(ddlLocationID.SelectedValue.ToString()), this.PortalId);
                GridView1.DataBind();

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public void LoadSettings()
        {
            try
            {

                if (Settings.Contains("locationsList"))
                {
                    _LocationsList = Settings["locationsList"].ToString();
                   
                }

                if (Settings.Contains("seatingList"))
                {
                    _SeatingList = Settings["seatingList"].ToString();

                }




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
                // Get State Dropdown from DNN Lists

               // var regions = new ListController().GetListEntryInfoItems(_LocationsList, "", this.PortalId);
                List<MealInfo> items;
                MealController controller = new MealController();

                items = MealController.GetLocations("1");

                ddlLocationID.DataTextField = "Location";
                ddlLocationID.DataValueField = "LocationID";
                ddlLocationID.DataSource = items;
                ddlLocationID.DataBind();
                ddlLocationID.Items.Insert(0, new ListItem("-- Please Select --", "0"));
                //  ddlLocationID.SelectedValue = "MA";

                //MTMealSeating  ddlSeating
                var seating = new ListController().GetListEntryInfoItems(_SeatingList, "", this.PortalId);
                ddlSeating.DataTextField = "Text";
                ddlSeating.DataValueField = "Value";
                ddlSeating.DataSource = seating;
                ddlSeating.DataBind();
                ddlSeating.Items.Insert(0, new ListItem("-- Please Select --", ""));
            }

            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }




        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            try
            {
                //  FillInvoiceGrid();
                GridView1.PageIndex = e.NewPageIndex;
                GridView1.DataSource = MealController.GetAllMeals(Int32.Parse(ddlLocationID.SelectedValue.ToString()), this.PortalId);
                GridView1.DataBind();

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }


        }

        // GridView1_RowEditing
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

            int itemID = (int)GridView1.DataKeys[e.NewEditIndex].Value;
            Panel1.Visible = true;
          
            
            MealController controller = new MealController();
            MealInfo item = controller.GetMeal(itemID);

            if (item != null)
            {
                HiddenMealID.Value = item.MealID.ToString();
                txtDeliveredEdit.Text = item.DeliveredCount.ToString();
                LabelLocation.Text = item.Location.ToString();
                LabelMeal.Text = item.Seating.ToString();
                txtMealDateEdit.Text = item.MealDate.ToShortDateString();
                txtFirstsCountEdit.Text = item.FirstsCount.ToString();
                txtSecondsCountEdit.Text = item.SecondsCount.ToString();
                txtAdultsCountEdit.Text = item.Adults.ToString();
            }

        }



            protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
         //   int itemID = (int)GridView1.DataKeys[e.RowIndex].Value;

            int itemID = (int)GridView1.DataKeys[e.RowIndex].Value;

            MealController.DeleteMeal(itemID);
            FillGrid();
          //  Response.Redirect(Globals.NavigateURL(TabId));
            //FillGrid();

        }


        // PRINT VIEW   
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int itemID = (int)GridView1.DataKeys[e.RowIndex].Value;
           

            //     Response.Redirect(Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Edit", "SkinSrc=[G]" + Globals.QueryStringEncode(SkinController.RootSkin + "/" + Globals.glbHostSkinFolder + "/" + "No Skin") + "&mid=" + ModuleId.ToString() + "&ItemId=" + itemID), true);

            // string MyURL =  Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Edit", "SkinSrc=[G]" + Globals.QueryStringEncode(SkinController.RootSkin + "/" + Globals.glbHostSkinFolder + "/" + "No Skin") + "&mid=" + ModuleId.ToString() + "&ItemId=" + itemID);

        }

        protected void LbSaveClick(object sender, EventArgs e)

        {
            hfSelecteValue.Value = ddlLocationID.SelectedValue.ToString();
            int _hidMealID = Convert.ToInt32(HiddenMealID.Value.ToString());
            lblDebug.Text = "Step 1 <br />";
            MealInfo mi;
            
            if (_hidMealID > 0)

            {
                lblDebug.Text += "MealID = 0 <br />";
                //    mi = ArticleController.GetArticle(ArticleId);
                //mi.MealDate = Convert.ToDateTime(txtMealDate.Text.ToString());
                //mi.Seating = txtPlatesServed.Text.ToString();
                //mi.ChildCount = txtChildCount.Text.ToString();
                //mi.LastModifiedOnDate = DateTime.Now;
                //mi.LastModifiedByUserId = UserInfo.UserID;
                //mi.ModuleId = ModuleId;

            }

            else

            {
                lblDebug.Text += "MealID = not exists <br />";
                string _notes = "";


                if (Int32.Parse(txtDelivered.Text.ToString()) > 0)
                {
                    if(DDLNoteDays.SelectedValue == "All" || DDLNoteDays.SelectedValue == "Mon")
                    {
                        _notes = txtMealNotes.Text.ToString();
                    }
                    else
                    {
                        _notes = "";
                    }
                    mi = new MealInfo

                    {

                        MealDate = Convert.ToDateTime(txtMealDate.Text.ToString()),
                        Seating = ddlSeating.SelectedValue.ToString(),
                        DeliveredCount = Convert.ToInt32(txtDelivered.Text.ToString()),
                        FirstsCount = Convert.ToInt32(txtFirstsCount.Text.ToString()),
                        SecondsCount = Convert.ToInt32(txtSecondsCount.Text.ToString()),
                        Location = ddlLocationID.SelectedItem.Text.ToString(),
                        LocationID = Int32.Parse(ddlLocationID.SelectedValue.ToString()),
                        Notes = _notes.ToString(),
                        CreatedByUserID = this.UserId,
                        MTPortalID = this.PortalId,
                        Adults = Convert.ToInt32(txtAdults.Text.ToString()),
                        DESE = CheckBoxDESE.Checked

                    };

                    mi.Save();

                }

                   

                if(Int32.Parse(txtDeliveredTues.Text.ToString()) > 0)
                {
                    if (DDLNoteDays.SelectedValue == "All" || DDLNoteDays.SelectedValue == "Tues")
                    {
                        _notes = txtMealNotes.Text.ToString();
                    }
                    else
                    {
                        _notes = "";
                    }
                    MealInfo miTues;
                    miTues = new MealInfo

                    {

                        MealDate = Convert.ToDateTime(txtMealDateTues.Text.ToString()),
                        Seating = ddlSeating.SelectedValue.ToString(),
                        DeliveredCount = Convert.ToInt32(txtDeliveredTues.Text.ToString()),
                        FirstsCount = Convert.ToInt32(txtFirstsCountTues.Text.ToString()),
                        SecondsCount = Convert.ToInt32(txtSecondsCountTues.Text.ToString()),
                        Location = ddlLocationID.SelectedItem.Text.ToString(),
                        LocationID = Int32.Parse(ddlLocationID.SelectedValue.ToString()),
                        Notes = _notes.ToString(),
                        CreatedByUserID = this.UserId,
                        MTPortalID = this.PortalId,
                        Adults = Convert.ToInt32(txtAdultsTues.Text.ToString()),
                        DESE = CheckBoxDESE.Checked

                    };

                    miTues.Save();
                }
                if (Int32.Parse(txtDeliveredWeds.Text.ToString()) > 0)
                    
                {
                    if (DDLNoteDays.SelectedValue == "All" || DDLNoteDays.SelectedValue == "Weds")
                    {
                        _notes = txtMealNotes.Text.ToString();
                    }
                    else
                    {
                        _notes = "";
                    }
                    MealInfo miWeds;
                    miWeds = new MealInfo

                    {

                        MealDate = Convert.ToDateTime(txtMealDateWeds.Text.ToString()),
                        Seating = ddlSeating.SelectedValue.ToString(),
                        DeliveredCount = Convert.ToInt32(txtDeliveredWeds.Text.ToString()),
                        FirstsCount = Convert.ToInt32(txtFirstsCountWeds.Text.ToString()),
                        SecondsCount = Convert.ToInt32(txtSecondsCountWeds.Text.ToString()),
                        Location = ddlLocationID.SelectedItem.Text.ToString(),
                        LocationID = Int32.Parse(ddlLocationID.SelectedValue.ToString()),
                        Notes = _notes.ToString(),
                        CreatedByUserID = this.UserId,
                        MTPortalID = this.PortalId,
                        Adults = Convert.ToInt32(txtAdultsWeds.Text.ToString()),
                        DESE = CheckBoxDESE.Checked

                    };

                    miWeds.Save();
                }

               
                if (Int32.Parse(txtDeliveredThurs.Text.ToString()) > 0)
                {
                    if (DDLNoteDays.SelectedValue == "All" || DDLNoteDays.SelectedValue == "Thurs")
                    {
                        _notes = txtMealNotes.Text.ToString();
                    }
                    else
                    {
                        _notes = "";
                    }
                    MealInfo miThurs;
                    miThurs = new MealInfo

                    {

                        MealDate = Convert.ToDateTime(txtMealDateThurs.Text.ToString()),
                        Seating = ddlSeating.SelectedValue.ToString(),
                        DeliveredCount = Convert.ToInt32(txtDeliveredThurs.Text.ToString()),
                        FirstsCount = Convert.ToInt32(txtFirstsCountThurs.Text.ToString()),
                        SecondsCount = Convert.ToInt32(txtSecondsCountThurs.Text.ToString()),
                        Location = ddlLocationID.SelectedItem.Text.ToString(),
                        LocationID = Int32.Parse(ddlLocationID.SelectedValue.ToString()),
                        Notes = _notes.ToString(),
                        CreatedByUserID = this.UserId,
                        MTPortalID = this.PortalId,
                        Adults = Convert.ToInt32(txtAdultsThurs.Text.ToString()),
                        DESE = CheckBoxDESE.Checked

                    };

                    miThurs.Save();
                }

                if (Int32.Parse(txtDeliveredFri.Text.ToString()) > 0)
                    
                {
                    if (DDLNoteDays.SelectedValue == "All" || DDLNoteDays.SelectedValue == "Fri")
                    {
                        _notes = txtMealNotes.Text.ToString();
                    }
                    else
                    {
                        _notes = "";
                    }
                    MealInfo miFri;
                    miFri = new MealInfo

                    {

                        MealDate = Convert.ToDateTime(txtMealDateFri.Text.ToString()),
                        Seating = ddlSeating.SelectedValue.ToString(),
                        DeliveredCount = Convert.ToInt32(txtDeliveredFri.Text.ToString()),
                        FirstsCount = Convert.ToInt32(txtFirstsCountFri.Text.ToString()),
                        SecondsCount = Convert.ToInt32(txtSecondsCountFri.Text.ToString()),
                        Location = ddlLocationID.SelectedItem.Text.ToString(),
                        LocationID = Int32.Parse(ddlLocationID.SelectedValue.ToString()),
                        Notes = _notes.ToString(),
                        CreatedByUserID = this.UserId,
                        MTPortalID = this.PortalId,
                        Adults = Convert.ToInt32(txtAdultsFri.Text.ToString()),
                        DESE = CheckBoxDESE.Checked

                    };

                    miFri.Save();
                }


            }
            ClearForm();
            FillGrid();
       

        }

        public void ClearForm()
        {

            try
            {
                ddlSeating.SelectedValue = null;
                txtFirstsCount.Text = "";
                txtSecondsCount.Text = "";
                txtAdults.Text = "";
                txtFirstsCountTues.Text = "";
                txtSecondsCountTues.Text = "";
                txtAdultsTues.Text = "";
                txtFirstsCountWeds.Text = "";
                txtSecondsCountWeds.Text = "";
                txtAdultsWeds.Text = "";
                txtFirstsCountThurs.Text = "";
                txtSecondsCountThurs.Text = "";
                txtAdultsThurs.Text = "";
                txtFirstsCountFri.Text = "";
                txtSecondsCountFri.Text = "";
                txtAdultsFri.Text = "";
                CheckBoxDESE.Checked = false;
                txtMealNotes.Text = string.Empty;
                DDLNoteDays.SelectedValue = string.Empty;
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public void ClearDelivered()
        {

            try
            {

                txtDelivered.Text = "";
                txtDeliveredTues.Text = "";
                txtDeliveredWeds.Text = "";
                txtDeliveredThurs.Text = "";
                txtDeliveredFri.Text = "";
                _DESE_Breakfast = false;
                _DESE_Lunch = false;
                _DESE_Snack = false;
                _DESE_Snack_PM = false;

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

        protected void LbCancelClick(object sender, EventArgs e)
        {

        }

        protected void lbReportClick(object sender, EventArgs e)
        {
          //  Response.Redirect(EditUrl("Report"));
            Response.Redirect(Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Report", "mid=" + ModuleId.ToString()));
        }

        protected void ddlLocationID_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearDelivered();
            hfSelecteValue.Value = ddlLocationID.SelectedValue.ToString();
            //ddlLocationID.Items.FindByValue(hfSelecteValue.Value.ToString()).Selected = true;
            FillGrid();
            LoadDeseSettings();


        }

        protected void ddlSeating_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string whatsSelected = ddlSeating.SelectedValue.ToString();
                switch (whatsSelected.ToString())
                {
                    case "Breakfast Seating":
                        CheckBoxDESE.Checked = _DESE_Breakfast;
                        break;
                    case "AM Snack":
                        CheckBoxDESE.Checked = _DESE_Snack;
                        break;
                    
                    case "Lunch Seating":
                        CheckBoxDESE.Checked = _DESE_Lunch;
                        break;
                    case "PM Snack":
                        CheckBoxDESE.Checked = _DESE_Snack_PM;
                        break;
                   
                    default:
                        CheckBoxDESE.Checked = false;
   break;
                }

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public void LoadDeseSettings()
        {
            try
            {

                MealController controller = new MealController();
                MealInfo item = controller.GetLocationByID(Int32.Parse(hfSelecteValue.Value.ToString()));

                if (item != null)
                {

                    _DESE_Breakfast = item.DESE_Breakfast;
                    _DESE_Lunch = item.DESE_Lunch;
                    _DESE_Snack = item.DESE_Snack;
                    _DESE_Snack_PM = item.DESE_Snack_PM;


                }
             //   lblDebug.Visible = true;
             //   lblDebug.Text = "_DESE_Breakfast: " + _DESE_Breakfast;
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }

        //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        DataRowView data = (DataRowView)e.Row.DataItem;
        //        LinkButton txtType = (LinkButton)e.Row.FindControl("LinkButtonUpdate");

        //        string _NicheID = DataBinder.Eval(e.Row.DataItem, "NicheID").ToString();
        //        string vLink = Globals.NavigateURL("ManageEdit", "Resource", _NicheID.ToString(), "mid", this.ModuleId.ToString());
        //        HyperLink myHyperLink = e.Row.FindControl("HyperLinkEdit") as HyperLink;
        //        myHyperLink.NavigateUrl = vLink.ToString();


        //    }
        //}


        public void UpdateMeal(int _mealID)
        {

            try
            {

                MealInfo mi_update;
                mi_update = new MealInfo

                {
                    MealID = _mealID,
                    DeliveredCount = Convert.ToInt32(txtDeliveredEdit.Text.ToString()),
                    FirstsCount = Convert.ToInt32(txtFirstsCountEdit.Text.ToString()),
                    SecondsCount = Convert.ToInt32(txtSecondsCountEdit.Text.ToString()),
                    Adults = Convert.ToInt32(txtAdultsCountEdit.Text.ToString())
                };

                mi_update.Save();

                FillGrid();
                Panel1.Visible = false;

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }


        protected void lbUpdateMeal_Click(object sender, EventArgs e)
        {
            // UPDATE ITEM HERE . . . .

            MealInfo mi_update;
            mi_update = new MealInfo

            {
                MealID = Int32.Parse(HiddenMealID.Value.ToString()),
                DeliveredCount = Convert.ToInt32(txtDeliveredEdit.Text.ToString()),
                FirstsCount = Convert.ToInt32(txtFirstsCountEdit.Text.ToString()),
                SecondsCount = Convert.ToInt32(txtSecondsCountEdit.Text.ToString()), 
                Adults = Convert.ToInt32( txtAdultsCountEdit.Text.ToString())
                
            };

            mi_update.Update();

            FillGrid();
            Panel1.Visible = false;

        }

        protected void LinkButtonCancelUpdate_Click(object sender, EventArgs e)
        {
            FillGrid();
            Panel1.Visible = false;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DataCommand")
            {
                // Get the value of command argument
                var _mealID = e.CommandArgument;

                if (_mealID != null)
                {
                    Panel1.Visible = true;


                    MealController controller = new MealController();
                    MealInfo item = controller.GetMeal(Int32.Parse(_mealID.ToString()));
                    
                    if (item != null)
                    {
                        HiddenMealID.Value = item.MealID.ToString();
                        txtDeliveredEdit.Text = item.DeliveredCount.ToString();
                        LabelLocation.Text = item.Location.ToString();
                        LabelMeal.Text = item.Seating.ToString();
                        txtMealDateEdit.Text = item.MealDate.ToShortDateString();
                        txtFirstsCountEdit.Text = item.FirstsCount.ToString();
                        txtSecondsCountEdit.Text = item.SecondsCount.ToString();
                        txtAdultsCountEdit.Text =   item.Adults.ToString();
                    }
                }
                // Do whatever operation you want.  
            }
        }

        protected void lbLocations_Click(object sender, EventArgs e)
        {
            //  Response.Redirect(EditUrl("Report"));
            Response.Redirect(Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Locations", "mid=" + ModuleId.ToString()));
        }


    }
}