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
using DotNetNuke.UI.Skins;
using DotNetNuke.UI.UserControls;
using System.Reflection.Emit;

namespace GIBS.Modules.MealTracker
{
    public partial class Locations : MealTrackerModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                FillGrid();



            }
        }

        public void FillGrid()
        {

            try
            {

                GridView1.DataSource = MealController.GetLocations("-1");
                GridView1.DataBind();

            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }

        }

        public void ClearForm()
        {
            try
            {
                
                txtLocationCode.Text = "";
                txtLocationName.Text = "";
                txtAddress.Text = "";
                txtCity.Text = "";
                txtRegion.Text = "MA";
                txtZipCode.Text = "";
                CheckBoxDESEBreakfast.Checked = false;
                CheckBoxDESELunch.Checked = false;
                CheckBoxDESESnack.Checked = false;
                CheckBoxDESESnackPM.Checked = false;
                CheckBoxIsActive.Checked = true;
                HiddenFieldLocationID.Value = "0";
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }





        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LabelDebug.Text = e.CommandName;

            if (e.CommandName == "DataCommand")
            {
                LabelDebug.Text = string.Empty;
                // Get the value of command argument
                var _LocationID = e.CommandArgument;

                if (_LocationID != null)
                {
                    Panel1.Visible = true;
                    LabelEditPanelMode.Text = "EDIT RECORD";

                    MealController controller = new MealController();
                    MealInfo item = controller.GetLocationByID(Int32.Parse(_LocationID.ToString()));

                    if (item != null)
                    {
                        HiddenFieldLocationID.Value = item.LocationID.ToString();
                        txtLocationName.Text = item.Location.ToString();
                        txtLocationCode.Text = item.LocationCode.ToString();
                        txtAddress.Text = item.Address.ToString();
                        txtCity.Text = item.City.ToString();
                        txtRegion.Text = item.Region.ToString();
                        CheckBoxDESEBreakfast.Checked = item.DESE_Breakfast;
                        CheckBoxDESELunch.Checked = item.DESE_Lunch;
                        CheckBoxDESESnack.Checked = item.DESE_Snack;
                        CheckBoxDESESnackPM.Checked = item.DESE_Snack_PM;
                        CheckBoxIsActive.Checked = item.IsActive;

                    }
                }
                // Do whatever operation you want.  
            }
        }

        protected void lbCancelUpdate_Click(object sender, EventArgs e)
        {
            ClearForm();
            FillGrid();
            Panel1.Visible = false;
            
        }



        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            // UPDATE ITEM HERE . . . .

            MealInfo mi_update;
            mi_update = new MealInfo

            {
                MTPortalID = this.PortalId,
                LocationCode = txtLocationCode.Text.ToString(),
                Location = txtLocationName.Text.ToString(),
                Address = txtAddress.Text.ToString(),
                City = txtCity.Text.ToString(),
                Region = txtRegion.Text.ToString(),
                ZipCode = txtZipCode.Text.ToString(),
                DESE_Breakfast = CheckBoxDESEBreakfast.Checked,
                DESE_Lunch = CheckBoxDESELunch.Checked,
                DESE_Snack = CheckBoxDESESnack.Checked,
                IsActive = CheckBoxIsActive.Checked,
                LastModifiedByUserID = this.UserId,
                LocationID = Int32.Parse(HiddenFieldLocationID.Value.ToString()),
                DESE_Snack_PM = CheckBoxDESESnackPM.Checked
                
            };
            if(Int32.Parse(HiddenFieldLocationID.Value.ToString()) > 0)
            {
                MealController.UpdateLocation(mi_update);
                LabelDebug.Visible = true;
                LabelDebug.Text = "Record Successfully Updated";
            }
            else
            {
                MealController.InsertLocation(mi_update);
                LabelDebug.Visible = true;
                LabelDebug.Text = "Record Successfully Inserted";
            }
            

            ClearForm();
            FillGrid();
            Panel1.Visible = false;
        }

        protected void LinkButtonAddNewLocation_Click(object sender, EventArgs e)
        {
            LabelDebug.Text = string.Empty;
            LabelEditPanelMode.Text = "ADD NEW RECORD";
            Panel1.Visible = true;
        }
    }
}