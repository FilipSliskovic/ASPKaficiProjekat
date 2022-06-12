namespace KaficiProjekat.API.Core
{
    public class AppSettings
    {
        public string ConnString { get; set; }
        public JwtSettings JwtSettings { get; set; }
        public string EmailFrom { get; set; }
        public string EmailPassword { get; set; }

    }
}
