﻿/*
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
using DotNetNuke.Entities.Modules;
//using GIBS.Modules.MealTracker.Components;

namespace GIBS.Modules.MealTracker
{
    public class MealTrackerModuleBase : PortalModuleBase
    {

        public int MealID

        {

            get

            {

                var qs = Request.QueryString["mealid"];

                if (qs != null)

                    return Convert.ToInt32(qs);

                return -1;

            }

        }



        public int PageNumber

        {

            get

            {

                var qs = Request.QueryString["p"];

                if (qs != null)

                    return Convert.ToInt32(qs);

                return 0;

            }

        }



        public int PageSize

        {

            get

            {

                if (Settings.Contains("PageSize"))

                    return Convert.ToInt32(Settings["PageSize"]);

                return 10;

            }

            set

            {

                var mc = new ModuleController();

                mc.UpdateModuleSetting(ModuleId, "PageSize", value.ToString());

            }

        }


    }
}