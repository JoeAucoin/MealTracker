/*
' Copyright (c) 2017  GIBS.com
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
                GridView1.DataSource = MealController.GetAllMeals(ModuleId);
                GridView1.DataBind();

                if (this.UserId > 1)
                {
                    DotNetNuke.Security.Roles.RoleController rolesController = new DotNetNuke.Security.Roles.RoleController();
                    UserRoleInfo role = rolesController.GetUserRole(0, this.UserId, rolesController.GetRoleByName(0, "Donor").RoleID);
                    DateTime expiryDate = role.ExpiryDate;
                    lblDebug.Text = expiryDate.ToShortDateString();
                }
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

                GridView1.DataSource = MealController.GetAllMeals(ModuleId);
                GridView1.DataBind();

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
            //PanelGrid.Visible = false;
            //PanelDriveDetail.Visible = true;

            int itemID = (int)GridView1.DataKeys[e.NewEditIndex].Value;

            MealController.DeleteMeal(itemID);
            Response.Redirect(Globals.NavigateURL(TabId));

            //MealController controller = new MealController();
            //MealInfo item = controller.MealGetDrive(this.ModuleId, itemID);

            //if (item != null)
            //{
            //    //  Response.Write(item);
            //    txtDriveName.Text = item.DriveName;
            //    txtDriveDate.Text = item.DriveDate.ToShortDateString();
            //    txtDriveNotes.Text = item.Description;
            //    txtReminder.Text = item.Reminder;
            //    txtPledgeLetter.Text = item.PledgeLetter;
            //    isActive.SelectedIndex = Convert.ToInt32(item.IsActive);
            //    HiddenItemID.Value = item.DriveID.ToString();

            //}
            //else
            //{
            //    HiddenItemID.Value = "";
            //}

        }



        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int itemID = (int)GridView1.DataKeys[e.RowIndex].Value;
            
            //GiftCertController controller = new GiftCertController();

            //controller.DeleteGiftCert(this.ModuleId, itemID);
            //FillGrid();

        }


        // PRINT VIEW   
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
//            int itemID = (int)GridView1.DataKeys[e.RowIndex].Value;

            //     Response.Redirect(Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Edit", "SkinSrc=[G]" + Globals.QueryStringEncode(SkinController.RootSkin + "/" + Globals.glbHostSkinFolder + "/" + "No Skin") + "&mid=" + ModuleId.ToString() + "&ItemId=" + itemID), true);

            // string MyURL =  Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Edit", "SkinSrc=[G]" + Globals.QueryStringEncode(SkinController.RootSkin + "/" + Globals.glbHostSkinFolder + "/" + "No Skin") + "&mid=" + ModuleId.ToString() + "&ItemId=" + itemID);

        }

        protected void LbSaveClick(object sender, EventArgs e)

        {

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
                mi = new MealInfo

                {
                  //  MealID = -1,
                    MealDate = Convert.ToDateTime(txtMealDate.Text.ToString()),
                    Seating = ddlSeating.SelectedValue.ToString(),
                    ChildCount = Convert.ToInt32(txtChildCount.Text.ToString()),
                    AdultCount = Convert.ToInt32(txtAdultCount.Text.ToString()),
                    PlatesServed = Convert.ToInt32(txtPlatesServed.Text.ToString()),
                    ModuleID = this.ModuleId,
                    Notes = txtMealNotes.Text.ToString(),
                    CreatedByUserID = this.UserId

                };
                // MealID = MealTracker.Components.MealController.SaveMeal(mi);
                mi.Save();       // MealTracker.Components.MealController.SaveMeal(mi);

                //lblDebug.Text = "Record Successfully Inserted";
                //lblDebug.Visible = true;

            }

        //    FillGrid();
            Response.Redirect(Globals.NavigateURL(TabId));

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
    }
}