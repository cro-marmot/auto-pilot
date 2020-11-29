#!/bin/bash

#Check if the script to be executed actually exists.
if [ ! -f $3 ]; then
    echo "Error: '$3' not found!"
    exit 1
fi

current_dir=$(pwd)

echo "Ephimeral directory: '$1'"
echo "Root namespace: '$2'"
echo "Program.cs file: '$3'"
echo "Current directory: '$current_dir'"

[ -e $1 ] && rm -rf $1
mkdir -p $1
cd $1
[ -e $3 ] && cp $3 Program.cs
echo "<Project Sdk=\"Microsoft.NET.Sdk\">" > dotnet-console-wrapper.csproj
echo " <PropertyGroup>" >> dotnet-console-wrapper.csproj
echo "  <OutputType>Exe</OutputType>" >> dotnet-console-wrapper.csproj
echo "  <TargetFramework>net5.0</TargetFramework>" >> dotnet-console-wrapper.csproj
echo "  <RootNamespace>$2</RootNamespace>" >> dotnet-console-wrapper.csproj
echo " </PropertyGroup>" >> dotnet-console-wrapper.csproj

#echo " <ItemGroup>" >> dotnet-console-wrapper.csproj
#echo "  <PackageReference Include=\"Microsoft.Azure.DocumentDB.Core\" Version=\"1.0.0\" />" >> dotnet-console-wrapper.csproj
#echo " </ItemGroup>" >> dotnet-console-wrapper.csproj

echo "</Project>" >> dotnet-console-wrapper.csproj

#dotnet add dotnet-console-wrapper.csproj package Microsoft.Azure.DocumentDB.Core -v 1.0.0

dotnet run
cd $current_dir
rm -rf $1
