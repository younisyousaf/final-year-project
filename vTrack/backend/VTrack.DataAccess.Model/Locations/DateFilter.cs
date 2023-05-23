using System;

namespace VTrack.DataAccess.Model.Locations;

public class DateFilter
{
    public virtual DateTime? StartDate { get; set; }
    public virtual DateTime? EndDate { get; set; }
}