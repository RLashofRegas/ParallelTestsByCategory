using System;
using System.Threading;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Reflection;

namespace ParallelTests
{
    [TestClass]
    public class UnitTests
    {
        [TestMethod]
        [TestingThread(0)]
        public void TestMethod1()
        {
            Thread.Sleep(5000);
        }

        
        [TestMethod]
        [TestingThread(1)]
        public void TestMethod2()
        {
            Thread.Sleep(5000);
        }
    }
}
