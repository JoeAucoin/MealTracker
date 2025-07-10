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
        public int ServiceDays { get; set; }
        public int MTPortalID { get; set; }
        public DateTime MealDate { get; set; }
        public string MonthYear { get; set; }
        public string Location { get; set; }
        public string Seating { get; set; }
        public int DeliveredCount { get; set; }
        public int FirstsCount { get; set; }
        public int TotalMealsCount { get; set; }
        public int SecondsCount { get; set; }
        public int Adults { get; set; }
        public int LeftOvers { get; set; }

        public int Short { get; set; }

        public int DamagedIncomplete { get; set; }
        public string DeliveryTime { get; set; }

        public DateTime DeliveryDateTime { get; set; }

        public int LocationID { get; set; }
        public string LocationCode { get; set; }
        public string LocationCodeSearchName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string ZipCode { get; set; }
        public bool DESE_Breakfast { get; set; }
        public bool DESE_Lunch { get; set; }
        public bool DESE_Snack { get; set; }
        public bool DESE_Snack_PM { get; set; }
        public bool DESE { get; set; }
        public bool IsActive { get; set; }
        public DateTime LastModifiedOnDate { get; set; }
        public int LastModifiedByUserID { get; set; }

        public int ModuleID { get; set; }
        public string Notes { get; set; }
        public DateTime CreatedOnDate { get; set; }
        public int CreatedByUserID { get; set; }

        public void Save()

        {

            MealID = MealTracker.Components.MealController.SaveMeal(this);
            //ArticleController.SaveArticle(this, tabId);

        }

        public void Update()
        {
            MealTracker.Components.MealController.UpdateMeal(this);
        }


    }
}