#!/bin/bash
# $1 is the directory that will hold the ephemeral dotnet console project that will be used as a wrapper.
# $2 is the name of the root namespace. This must match with the namespace provided in the .cs file that will be used as Program.cs
# $3 is the .cs file that will be used as Program cs.

#chmod +x executor.sh
#./executor.sh /Users/admin/ephemeral dotnet_console_wrapper /Users/admin/dotnet-console-wrapper/Program.cs

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
echo "</Project>" >> dotnet-console-wrapper.csproj
dotnet run
cd $current_dir
rm -rf $1
