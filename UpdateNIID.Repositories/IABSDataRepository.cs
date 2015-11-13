using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UpdateNIID.Model;

namespace UpdateNIID.Repositories
{
   
    public interface IABSDataRepository : IRepository<MotorDetailsOnline, Int32?>
    {
        IList<MotorDetailsOnline> MotorDetails();
        void MoveData(MotorDetailsOnline md);

    }
}
