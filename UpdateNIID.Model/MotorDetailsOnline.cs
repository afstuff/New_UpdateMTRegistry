using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UpdateNIID.Model
{
    public class MotorDetailsOnline
    {
        public virtual int? mId { get; set; }
        public virtual string Username { get; set; }
        public virtual string Password { get; set; }
        public virtual string NiaNaicomID { get; set; }
        public virtual string PolicyNo { get; set; }
        public virtual string InsuredName { get; set; }
        public virtual string ContactAddress { get; set; }
        public virtual string GSMNo { get; set; }
        public virtual string Email { get; set; }
        public virtual string EffectiveCoverDate { get; set; }
        public virtual string ExpirationDate { get; set; }
        public virtual string TypeOfCover { get; set; }
        public virtual string VehicleCategory { get; set; }
        public virtual string EngineNo { get; set; }
        public virtual string ChasisNo { get; set; }
        public virtual string VehicleColor { get; set; }
        public virtual string YearofMake { get; set; }
        public virtual string VehicleMake { get; set; }
        public virtual string RegistrationNo { get; set; }
        public virtual string VehicleType { get; set; }
        public virtual string EngineCapacity { get; set; }
        public virtual string VehicleModel { get; set; }
        public virtual Double SumAssured { get; set; }
        public virtual Double Premium { get; set; }
        public virtual string CoverNoteNo { get; set; }
        public virtual string CertificateNo { get; set; }
        public virtual string GeographicalZone { get; set; }
        public virtual string Status { get; set; }
        public virtual string ReturnMessage { get; set; }
        public virtual DateTime ProcessDate { get; set; }
        public virtual DateTime UploadDate { get; set; }


    }
}
