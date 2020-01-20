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

        public static List<MealInfo> GetAllMeals(int moduleID)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_Get(moduleID));

        }

        public static List<MealInfo> Report(int moduleID, string startDate, string endDate)

        {   //todo: look at caching

            return CBO.FillCollection<MealInfo>(DataProvider.Instance().MealTracker_Report(moduleID, startDate, endDate));

        }


        public static int SaveMeal(MealInfo mi)

        {

            if (mi.MealID > 0)

            {
                // NEED UPDATE
                //mi.MealID = DataProvider.Instance().MealTracker_UpdateMeal(mi);

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

    }
}