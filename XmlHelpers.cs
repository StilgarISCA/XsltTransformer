using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;

namespace XsltTransformer
{
   public static class XmlHelpers
   {
      public static XmlReader GetXmlReader( string pathToXml )
      {
         var xmlReaderSettings = new XmlReaderSettings();
         xmlReaderSettings.DtdProcessing = DtdProcessing.Parse;

         return XmlReader.Create( pathToXml, xmlReaderSettings );
      }

      public static XmlWriter GetXmlWriter( string pathToOutput )
      {
         return XmlWriter.Create( pathToOutput );
      }

      public static void XmlXsltTransform( string pathToXsl, string pathToXmlInput, string pathToOutput )
      {
         var xslt = new XslCompiledTransform();
         xslt.Load( pathToXsl );
         xslt.Transform( GetXmlReader( pathToXmlInput ), GetXmlWriter( pathToOutput ) );
      }
   }
}
