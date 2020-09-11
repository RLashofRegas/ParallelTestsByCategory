using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;

namespace ParallelTests
{
    public class TestingThreadAttribute : TestCategoryBaseAttribute
    {
        public TestingThreadAttribute(int thread)
            : base()
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: true)
                .Build();

            string categoryToEnable = configuration.GetSection("category").Value;
            
            if ($"category{thread}" == categoryToEnable)
            {
                TestCategories = new List<string> { "enable" };
            }
            else
            {
                TestCategories = new List<string> { };
            }
        }

        public override IList<string> TestCategories { get; }
    }
}