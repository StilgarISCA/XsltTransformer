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
      public static void Main(string[] args)
      {
         var xmlReaderSettings = new XmlReaderSettings();
         xmlReaderSettings.DtdProcessing = DtdProcessing.Parse;

         XmlReader xmlReader = XmlReader.Create( "../../fuel.xml", xmlReaderSettings );

         XmlWriter xmlWriter = XmlWriter.Create( "../../fuel.html") ;

         var xslt = new XslCompiledTransform();
         xslt.Load( "../../print.xsl" );
         //xslt.Transform( "../../fuel.xml", "../../fuel.html" );
         xslt.Transform( xmlReader, xmlWriter );
      }
   }
}
