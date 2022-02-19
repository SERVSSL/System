using System;
using System.Reflection;

namespace SERVWeb
{
    public sealed class AssetVersion
    {
        private static readonly Lazy<AssetVersion> lazy =
            new Lazy<AssetVersion>(() => new AssetVersion());

        private static string _number;

        public static AssetVersion Instance { get { return lazy.Value; } }

        public string Number
        {
            get
            {
                return _number;
            }
        }

        private AssetVersion()
        {
            var buildDate = System.IO.File.GetLastWriteTime(Assembly.GetExecutingAssembly().Location);
            _number = string.Format("{0}{1:000}{2:00}{3:00}{4:00}", buildDate.Year, buildDate.DayOfYear, buildDate.Hour, buildDate.Minute, buildDate.Second);
        }
    }
}