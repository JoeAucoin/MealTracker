using GIBS.Modules.MealTracker.Data;
using DotNetNuke.Common.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GIBS.Modules.MealTracker.Components
{
    public class MealController
    {

        public MealInfo GetLocationByID(int locationID)
        {
            return CBO.FillObject<MealInfo>(DataProvider.Instance().GetLocationByID(locationID));

        }
        public MealInfo GetMeal(int mealID)
        {
            return CBO.FillObject<MealInfo>(DataProvider.Instance().GetMeal(mealID));

        }

        public static List<MealInfo> GetLocations(string isActive)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_GetLocations(isActive));

        }

        public static List<MealInfo> GetLocationTowns(string isActive)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_GetLocationTowns(isActive));

        }


        public static List<MealInfo> GetLocationCodeSearchNames()

        {

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_GetLocationCodeSearchNames());

        }


        public static List<MealInfo> GetAllMeals(int locationID, int portalID)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_Get(locationID, portalID));

        }

        public static List<MealInfo> GetAllMealsLite(int locationID, int portalID, string startDate, string endDate)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_GetLite(locationID, portalID, startDate, endDate));

        }

        public static List<MealInfo> Report(string location, string startDate, string endDate, int portalID, string city, string locationCode)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_Report(location, startDate, endDate, portalID, city, locationCode));

        }


        public static List<MealInfo> ReportSummary(string location, string startDate, string endDate, int portalID, string city, string locationCode)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_ReportSummary(location, startDate, endDate, portalID, city, locationCode));

        }

        public static int SaveMeal(MealInfo mi)

        {

            if (mi.MealID > 0)

            {
                // NEED UPDATE
              //  DataProvider.Instance().MealTracker_MealUpdate(mi);
              //  mi.MealID = 0;

                //var cntTaxonomy = new Taxonomy.Content();

                //var objContentItem = cntTaxonomy.CreateContentItem(a, tabId);

                //a.ContentItemId = objContentItem.ContentItemId;

                //SaveArticle(a, tabId);

            }

            else

            {

                mi.MealID = DataProvider.Instance().MealTracker_AddMeal(mi);

                //var cntTaxonomy = new Taxonomy.Content();
                //cntTaxonomy.UpdateContentItem(a, tabId);

            }

            return mi.MealID;

        }

        public static void DeleteMeal(int mealID)
        {
            DataProvider.Instance().DeleteMeal(mealID);
        }

        public static void UpdateMeal(MealInfo mi)
        {
            DataProvider.Instance().MealTracker_MealUpdate(mi);
        }

        public static void UpdateMealAll(MealInfo mi)
        {
            DataProvider.Instance().MealTracker_MealUpdateAll(mi);
        }

        public static void UpdateLocation(MealInfo mi)
        {
            DataProvider.Instance().MealTracker_UpdateLocation(mi);
        }

        public static void InsertLocation(MealInfo mi)
        {
            DataProvider.Instance().MealTracker_InsertLocation(mi);
        }

    }
}