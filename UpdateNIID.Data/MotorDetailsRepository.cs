using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using UpdateNIID.Model;
using UpdateNIID.Repositories;
using NHibernate;

namespace UpdateNIID.Data
{
    public class MotorDetailsRepository : IABSDataRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(MotorDetailsOnline saveObj)
        {
            using (var session = GetSession())
            {
                using (var trans = session.BeginTransaction())
                {
                    session.FlushMode = FlushMode.Commit;
                    session.SaveOrUpdate(saveObj);
                    trans.Commit();
                    session.Flush();
                    //}
                }
            }
        }
        public void Delete(MotorDetailsOnline delObj)
        {
            using (var session = GetSession())
            {
                using (var trans = session.BeginTransaction())
                {
                    session.Delete(delObj);
                    trans.Commit();
                }
            }
        }
        public IList<MotorDetailsOnline> MotorDetails()
        {
            try
            {
                using (var session = GetSession())
                {
                    if (session != null)
                    {
                        var pDet = session.CreateCriteria<MotorDetailsOnline>()

                            .List<MotorDetailsOnline>();

                        return pDet;
                    }
                    return null;
                }
            }
            catch (Exception nex)
            {
                //string k = nex.InnerException.Message;

                return null;

            }

        }


        public MotorDetailsOnline GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<MotorDetailsOnline>(id);
            }
        }
        public MotorDetailsOnline GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from MotorDetailsOnline i where i.ebId = " + keys[0]
                              + " and i.MeterNo = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (MotorDetailsOnline)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

        public void MoveData(MotorDetailsOnline md)
        {

        }


        public void createSchema()
        {
            SessionProvider.RebuildSchema();
        }



        private static DataTable GetDataTable(string qry)
        {
            try
            {
                using (var session = GetSession())
                {
                    using (var conn = session.Connection as SqlConnection)
                    {
                        var adapter = new SqlDataAdapter(qry, conn);
                        var dataSet = new System.Data.DataSet();

                        adapter.Fill(dataSet);
                        DataTable dt = dataSet.Tables[0];

                        return dt;
                    }
                }
            }
            catch (Exception nex)
            {
                //string k = nex.InnerException.Message;

                return null;

            }

        }

        public DataTable GetMotorDetailsDt(string startDate, string endDate, int filter, string sValue)
        {
            string query, query1;

            if (sValue == "*")
            {

            }

            query = "SELECT * "
                          + "FROM NIID_MotorDetails_Online where (NIID_Status <> 'X') ";


            if (filter == 1)
            {

                query += "AND (NIID_InsuredName LIKE '%" + sValue + "%') ";


            }
            else if (filter == 2)
            {

                query += "AND (NIID_PolicyNo LIKE '%" + sValue + "%') ";
            }
            else if (filter == 3)
            {
                query += "AND (NIID_RegistrationNo LIKE '%" + sValue + "%') ";
            }
            else if (filter == 0)
            {
                query += "";
            }

            if (startDate == "1/1/1700 12:00:00 AM")
            {
                query += " order by NIID_UploadDate desc";

            }
            else
            {
                query += " AND (NIID_UploadDate BETWEEN '" + startDate + "' AND '" + endDate + "') order by NIID_UploadDate desc";
            }

            return GetDataTable(query);
        }

        public DataTable GetMotorDetailsAllDt()
        {
            //queries the generic admincodes table and extract info for the vehicles only
            string query = "SELECT * "
                          + "FROM NIID_MotorDetails_Online where (NIID_Status <> 'X' ) order by NIID_UploadDate desc";

            return GetDataTable(query);
        }

        public MotorDetailsOnline GetByPolicyNo(int _polyNo)
        {
            using (var session = GetSession())
            {
                return session.CreateCriteria<MotorDetailsOnline>().List<MotorDetailsOnline>().Where(c => c.mId == _polyNo).FirstOrDefault();

            }
        }

        public void Update(int _polyNo)
        {
            using (var session = GetSession())
            {

                using (var trans = session.BeginTransaction())
                {
                    //MotorDetailsOnline saveObj = null;
                    var search = GetByPolicyNo(_polyNo);
                    if (search != null)
                    {
                        search.Status = "X";

                        session.FlushMode = FlushMode.Commit;
                        session.SaveOrUpdate(search);
                        trans.Commit();
                        session.Flush();
                    }
                    //}
                }
            }
        }

        public void Update1(int _polyNo)
        {
            using (var session = GetSession())
            {

                using (var trans = session.BeginTransaction())
                {
                    //MotorDetailsOnline saveObj = null;
                    var search = GetByPolicyNo(_polyNo);
                    if (search != null)
                    {
                        search.Status = "A";

                        session.FlushMode = FlushMode.Commit;
                        session.SaveOrUpdate(search);
                        trans.Commit();
                        session.Flush();
                    }
                    //}
                }
            }
        }

        public int NetworkStatus()
        {
            try
            {
                MotorDetailsOnline md = GetById(1);
            }
            catch (NetworkInformationException v)
            {

                string d = v.Message;
                return 0;
            }
            catch (Exception y)
            {

                //string k = y.InnerException.Message;
                return 0;
            }
            return 1;
        }


    }
}
