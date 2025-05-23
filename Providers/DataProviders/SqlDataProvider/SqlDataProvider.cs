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


using System;
using System.Data;
using System.Data.SqlClient;
using GIBS.Modules.MealTracker.Components;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Framework.Providers;
using Microsoft.ApplicationBlocks.Data;

namespace GIBS.Modules.MealTracker.Data
{

    /// -----------------------------------------------------------------------------
    /// <summary>
    /// SQL Server implementation of the abstract DataProvider class
    /// 
    /// This concreted data provider class provides the implementation of the abstract methods 
    /// from data dataprovider.cs
    /// 
    /// In most cases you will only modify the Public methods region below.
    /// </summary>
    /// -----------------------------------------------------------------------------
    public class SqlDataProvider : DataProvider
    {

        #region Private Members

        private const string ProviderType = "data";
        private const string ModuleQualifier = "GIBS_";

        private readonly ProviderConfiguration _providerConfiguration = ProviderConfiguration.GetProviderConfiguration(ProviderType);
        private readonly string _connectionString;
        private readonly string _providerPath;
        private readonly string _objectQualifier;
        private readonly string _databaseOwner;

        #endregion

        #region Constructors

        public SqlDataProvider()
        {

            // Read the configuration specific information for this provider
            Provider objProvider = (Provider)(_providerConfiguration.Providers[_providerConfiguration.DefaultProvider]);

            // Read the attributes for this provider

            //Get Connection string from web.config
            _connectionString = Config.GetConnectionString();

            if (string.IsNullOrEmpty(_connectionString))
            {
                // Use connection string specified in provider
                _connectionString = objProvider.Attributes["connectionString"];
            }

            _providerPath = objProvider.Attributes["providerPath"];

            _objectQualifier = objProvider.Attributes["objectQualifier"];
            if (!string.IsNullOrEmpty(_objectQualifier) && _objectQualifier.EndsWith("_", StringComparison.Ordinal) == false)
            {
                _objectQualifier += "_";
            }

            _databaseOwner = objProvider.Attributes["databaseOwner"];
            if (!string.IsNullOrEmpty(_databaseOwner) && _databaseOwner.EndsWith(".", StringComparison.Ordinal) == false)
            {
                _databaseOwner += ".";
            }

        }

        #endregion

        #region Properties

        public string ConnectionString
        {
            get
            {
                return _connectionString;
            }
        }

        public string ProviderPath
        {
            get
            {
                return _providerPath;
            }
        }

        public string ObjectQualifier
        {
            get
            {
                return _objectQualifier;
            }
        }

        public string DatabaseOwner
        {
            get
            {
                return _databaseOwner;
            }
        }

        // used to prefect your database objects (stored procedures, tables, views, etc)
        private string NamePrefix
        {
            get { return DatabaseOwner + ObjectQualifier + ModuleQualifier; }
        }

        #endregion

        #region Private Methods

        private static object GetNull(object field)
        {
            return Null.GetNull(field, DBNull.Value);
        }

        #endregion

        #region Public Methods
        public override IDataReader MealTracker_GetLocations(string isActive)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetLocations", isActive);
        }
        public override IDataReader MealTracker_GetLocationCodeSearchNames()
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetLocationCodeSearchNames");
        }
        public override IDataReader MealTracker_GetLocationTowns(string isActive)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetLocationTowns", isActive);
        }
        public override IDataReader MealTracker_Get(int locationID, int portalID)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_Get", locationID, portalID);
        }

        public override IDataReader MealTracker_GetLite(int locationID, int portalID, string startDate, string endDate)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetLite", locationID, portalID, startDate, endDate);
        }

        public override IDataReader MealTracker_Report(string location, string startDate, string endDate, int portalID, string city, string locationCode)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_Report", location, startDate, endDate, portalID, city, locationCode);
        }

        public override IDataReader MealTracker_ReportSummary(string location, string startDate, string endDate, int portalID, string city, string locationCode)
        {
            return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_ReportSummary", location, startDate, endDate, portalID, city, locationCode);
        }

        ////DateTime mealDate, string seating, int childCount, int adultCount, int platesServed, int moduleID, string notes, int createdByUserID

        public override int MealTracker_AddMeal(MealInfo mi)
        {
            return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString, NamePrefix + "MealTracker_Insert"
                , new SqlParameter("@MealDate", mi.MealDate)
                 , new SqlParameter("@Location", mi.Location)
                 , new SqlParameter("@LocationID", mi.LocationID)
                , new SqlParameter("@Seating", mi.Seating)
                , new SqlParameter("@DeliveredCount", mi.DeliveredCount)
                , new SqlParameter("@FirstsCount", mi.FirstsCount)
                , new SqlParameter("@SecondsCount", mi.SecondsCount)
                , new SqlParameter("@Notes", mi.Notes)
                 , new SqlParameter("@CreatedByUserID", mi.CreatedByUserID)
                , new SqlParameter("@PortalID", mi.MTPortalID)
                , new SqlParameter("@Adults", mi.Adults)
                , new SqlParameter("@DESE", mi.DESE)
                , new SqlParameter("@DeliveryTime", mi.DeliveryTime)
                , new SqlParameter("@DamagedIncomplete", mi.DamagedIncomplete)
                 , new SqlParameter("@Short", mi.Short)
                ));
        }

        public override void MealTracker_MealUpdate(MealInfo mi)
        {
            SqlHelper.ExecuteNonQuery(ConnectionString, NamePrefix + "MealTracker_MealUpdate"

                , new SqlParameter("@DeliveredCount", mi.DeliveredCount)
                , new SqlParameter("@FirstsCount", mi.FirstsCount)
                , new SqlParameter("@SecondsCount", mi.SecondsCount)
                , new SqlParameter("@MealID", mi.MealID)
                , new SqlParameter("@Adults", mi.Adults)
                , new SqlParameter("@DeliveryTime", mi.DeliveryTime)
                , new SqlParameter("@DamagedIncomplete", mi.DamagedIncomplete)
                , new SqlParameter("@Short", mi.Short)
                , new SqlParameter("@Notes", mi.Notes)
                );
        }

        public override void DeleteMeal(int mealID)
        {
            SqlHelper.ExecuteNonQuery(ConnectionString, CommandType.StoredProcedure, NamePrefix + "MealTracker_Delete", new SqlParameter("@MealID", mealID));
        }

        public override IDataReader GetMeal(int mealID)
        {
            return (IDataReader)SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetMeal", mealID);
        }

        public override IDataReader GetLocationByID(int locationID)
        {
            return (IDataReader)SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "MealTracker_GetLocationByID", locationID);
        }

        public override void MealTracker_UpdateLocation(MealInfo mi)
        {
            SqlHelper.ExecuteNonQuery(ConnectionString, NamePrefix + "MealTracker_LocationUpdate"

                , new SqlParameter("@LocationCode", mi.LocationCode)
                , new SqlParameter("@Location", mi.Location)
                , new SqlParameter("@Address", mi.Address)
                , new SqlParameter("@City", mi.City)
                , new SqlParameter("@Region", mi.Region)
                , new SqlParameter("@ZipCode", mi.ZipCode)
                , new SqlParameter("@DESE_Breakfast", mi.DESE_Breakfast)
                , new SqlParameter("@DESE_Lunch", mi.DESE_Lunch)
                , new SqlParameter("@DESE_Snack", mi.DESE_Snack)
                , new SqlParameter("@IsActive", mi.IsActive)
                , new SqlParameter("@LastModifiedByUserID", mi.LastModifiedByUserID)
                , new SqlParameter("@LocationID", mi.LocationID)
                , new SqlParameter("@DESE_Snack_PM", mi.DESE_Snack_PM)
                );
        }

        public override void MealTracker_InsertLocation(MealInfo mi)
        {
            SqlHelper.ExecuteNonQuery(ConnectionString, NamePrefix + "MealTracker_LocationInsert"
                , new SqlParameter("@PortalID", mi.MTPortalID)
                , new SqlParameter("@LocationCode", mi.LocationCode)
                , new SqlParameter("@Location", mi.Location)
                , new SqlParameter("@Address", mi.Address)
                , new SqlParameter("@City", mi.City)
                , new SqlParameter("@Region", mi.Region)
                , new SqlParameter("@ZipCode", mi.ZipCode)
                , new SqlParameter("@DESE_Breakfast", mi.DESE_Breakfast)
                , new SqlParameter("@DESE_Lunch", mi.DESE_Lunch)
                , new SqlParameter("@DESE_Snack", mi.DESE_Snack)
                , new SqlParameter("@IsActive", mi.IsActive)
                , new SqlParameter("@LastModifiedByUserID", mi.LastModifiedByUserID)
                 , new SqlParameter("@DESE_Snack_PM", mi.DESE_Snack_PM)

                );
        }

        //public override IDataReader GetItem(int itemId)
        //{
        //    return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "spGetItem", itemId);
        //}

        //public override IDataReader GetItems(int userId, int portalId)
        //{
        //    return SqlHelper.ExecuteReader(ConnectionString, NamePrefix + "spGetItemsForUser", userId, portalId);
        //}


        #endregion

    }

}