using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Content;

namespace GIBS.Modules.MealTracker.Components
{
    public class MealInfo
    {
        public int MealID { get; set; }
        public DateTime MealDate { get; set; }
        public string Seating { get; set; }
        public int ChildCount { get; set; }
        public int AdultCount { get; set; }
        public int HeadCount { get; set; }
        public int PlatesServed { get; set; }
        public int ModuleID { get; set; }
        public string Notes { get; set; }
        public DateTime CreatedOnDate { get; set; }
        public int CreatedByUserID { get; set; }

        public void Save()

        {

            MealID = MealTracker.Components.MealController.SaveMeal(this);
            //ArticleController.SaveArticle(this, tabId);

        }

    }
}