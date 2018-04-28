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

         foreach( var issuePath in pathsToIssues )
         {
            IEnumerable<string> pathsToArticles = FileHelpers.GetIssueContentsAtPath( issuePath );
            foreach( var articlePath in pathsToArticles )
            {
               XmlHelpers.XmlXsltTransform( "../../print.xsl", articlePath, "../../output.html" );
            }
         }
      }
   }
}
