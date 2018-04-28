using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace XsltTransformer
{
   public static class FileHelpers
   {
      public static IEnumerable<string> GetIssueFoldersAtPath( string pathToSearch )
      {
         var matchYyyyMmDdNames = new Regex("[0-9]{8}");

         return (from dir in Directory.GetDirectories( pathToSearch ) where matchYyyyMmDdNames.IsMatch( dir ) select dir);
      }
   }
}
