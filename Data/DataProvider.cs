/*
' Copyright (c) 2023 GIBS.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System.Data;
using System;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Framework.Providers;
using GIBS.Modules.MealTracker.Components;

namespace GIBS.Modules.MealTracker.Data
{

    /// -----------------------------------------------------------------------------
    /// <summary>
    /// An abstract class for the data access layer
    /// 
    /// The abstract data provider provides the methods that a control data provider (sqldataprovider)
    /// must implement. You'll find two commented out examples in the Abstract methods region below.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public abstract class DataProvider
    {

        #region Shared/Static Methods

        private static DataProvider provider;

        // return the provider
        public static DataProvider Instance()
        {
            if (provider == null)
            {
                const string assembly = "GIBS.Modules.MealTracker.Data.SqlDataprovider,MealTracker";
                Type objectType = Type.GetType(assembly, true, true);

                provider = (DataProvider)Activator.CreateInstance(objectType);
                DataCache.SetCache(objectType.FullName, provider);
            }

            return provider;
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1024:UsePropertiesWhereAppropriate", Justification = "Not returning class state information")]
        public static IDbConnection GetConnection()
        {
            const string providerType = "data";
            ProviderConfiguration _providerConfiguration = ProviderConfiguration.GetProviderConfiguration(providerType);

            Provider objProvider = ((Provider)_providerConfiguration.Providers[_providerConfiguration.DefaultProvider]);
            string _connectionString;
            if (!String.IsNullOrEmpty(objProvider.Attributes["connectionStringName"]) && !String.IsNullOrEmpty(System.Configuration.ConfigurationManager.AppSettings[objProvider.Attributes["connectionStringName"]]))
            {
                _connectionString = System.Configuration.ConfigurationManager.AppSettings[objProvider.Attributes["connectionStringName"]];
            }
            else
            {
                _connectionString = objProvider.Attributes["connectionString"];
            }

            IDbConnection newConnection = new System.Data.SqlClient.SqlConnection();
            newConnection.ConnectionString = _connectionString.ToString();
            newConnection.Open();
            return newConnection;
        }

        #endregion

        #region Abstract methods

        //public abstract IDataReader GetItems(int userId, int portalId);

        //public abstract IDataReader GetItem(int itemId);        
        public abstract IDataReader MealTracker_GetLocations(string isActive);
        public abstract IDataReader MealTracker_GetLocationTowns(string isActive);
        public abstract IDataReader MealTracker_GetLocationCodeSearchNames();
        public abstract IDataReader MealTracker_Get(int locationID, int portalID);
        public abstract IDataReader MealTracker_Report(string location, string startDate, string endDate, int portalID, string city, string locationCode);
        public abstract IDataReader MealTracker_ReportSummary(string location, string startDate, string endDate, int portalID, string city, string locationCode);
        ////    public abstract IDataReader MealTracker_GetMeal(int mealID);
        public abstract int MealTracker_AddMeal(MealInfo mi);
        public abstract void MealTracker_MealUpdate(MealInfo mi);
        public abstract void DeleteMeal(int mealID);

        public abstract IDataReader GetMeal(int mealID);
        public abstract IDataReader GetLocationByID(int locationID);

        public abstract void MealTracker_UpdateLocation(MealInfo mi);

        public abstract void MealTracker_InsertLocation(MealInfo mi);
        #endregion

    }

}