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

using DotNetNuke.Entities.Modules;

namespace GIBS.Modules.MealTracker
{
    public class MealTrackerModuleSettingsBase : ModuleSettingsBase
    {
        public string JQueryUI
        {
            get
            {
                if (Settings.Contains("jQueryUI"))
                    return Settings["jQueryUI"].ToString();
                return "";
            }
            set
            {
                var mc = new ModuleController();
                mc.UpdateTabModuleSetting(TabModuleId, "jQueryUI", value.ToString());
            }
        }

        public string LocationsList
        {
            get
            {
                if (Settings.Contains("locationsList"))
                    return Settings["locationsList"].ToString();
                return "";
            }
            set
            {
                var mc = new ModuleController();
                mc.UpdateTabModuleSetting(TabModuleId, "locationsList", value.ToString());
            }
        }

        public string SeatingList
        {
            get
            {
                if (Settings.Contains("seatingList"))
                    return Settings["seatingList"].ToString();
                return "";
            }
            set
            {
                var mc = new ModuleController();
                mc.UpdateTabModuleSetting(TabModuleId, "seatingList", value.ToString());
            }
        }

    }
}