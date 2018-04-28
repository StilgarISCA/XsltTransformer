using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;

namespace XsltTransformer
{
   public class Program
   {
      public static string RootPath = @"c:\projects\issues\";

      public static void Main(string[] args)
      {
         IEnumerable<string> pathsToIssues = FileHelpers.GetIssueFoldersAtPath( RootPath );

         XmlHelpers.XmlXsltTransform( "../../print.xsl", "../../fuel.xml", "../../output.html" );
      }
   }
}
