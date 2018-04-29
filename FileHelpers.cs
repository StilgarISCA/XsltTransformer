using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace XsltTransformer
{
   public static class FileHelpers
   {
      public static string OutputPath = @"../../../Transformed/";

      public static void CopyImagesFolder( string issuesFolder )
      {
         string issueDate = GetIssueDateFromPath( issuesFolder );
         string sourceFolder = $"{issuesFolder}\\images";
         string targetFolder = $"{OutputPath}/{issueDate}/images";

         Directory.CreateDirectory( targetFolder );

         IEnumerable<string> imageFiles = Directory.EnumerateFiles( sourceFolder );

         foreach ( var image in imageFiles )
         {
            string fileName = Path.GetFileName( image );
            string targetFile = $"{targetFolder}/{fileName}";
            File.Copy( image, targetFile, true );
         }
      }

      public static IEnumerable<string> GetIssueContentsAtPath( string pathToFolder )
      {
         return Directory.EnumerateFiles( pathToFolder, "*.xml" ).Where( f => (!f.EndsWith( "cover.xml" ))  );
      }

      private static string GetIssueDateFromPath( string pathToParse )
      {
         // Add a trailing slash if it's a folder path
         if( IsDirectory( pathToParse ) )
         {
            pathToParse = $"{pathToParse}/";
         }

         return Path.GetDirectoryName( pathToParse ).Split( Path.DirectorySeparatorChar ).Last();
      }

      public static IEnumerable<string> GetIssueFoldersAtPath( string pathToSearch )
      {
         var matchYyyyMmDdNames = new Regex("[0-9]{8}");

         return (from dir in Directory.GetDirectories( pathToSearch ) where matchYyyyMmDdNames.IsMatch( dir ) select dir);
      }

      private static bool IsDirectory( string pathToTest )
      {
         return File.GetAttributes( pathToTest ).HasFlag( FileAttributes.Directory );
      }

      public static string SetUpOutputPath( string articlePath )
      {
         string fileName = Path.GetFileNameWithoutExtension( articlePath );
         string issueDate = GetIssueDateFromPath( articlePath );
         string issueOutputPath = $"{OutputPath}{issueDate}";

         Directory.CreateDirectory( issueOutputPath );

         return $"{issueOutputPath}/{fileName}.html";
      }
   }
}
