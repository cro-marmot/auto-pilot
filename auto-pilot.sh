#!/bin/bash

#Check if the script to be executed actually exists.
if [ ! -f $1 ]; then
    echo "Error: '$1' not found!"
    exit 1
fi

default_ephimeral_dir=~/.auto-pilot/ephimeral
default_root_namespace=autopilot
default_csproj_file=autopilot.csproj
current_dir=$(pwd)

echo "Ephimeral directory: '$default_ephimeral_dir'"
echo "Root namespace: '$default_root_namespace'"
echo "Program.cs file: '$1'"
echo "Current directory: '$current_dir'"

[ -e $default_ephimeral_dir ] && rm -rf $default_ephimeral_dir
mkdir -p $default_ephimeral_dir
cd $default_ephimeral_dir
cp $1 Program.cs
echo "<Project Sdk=\"Microsoft.NET.Sdk\">" > $default_csproj_file
echo " <PropertyGroup>" >> $default_csproj_file
echo "  <OutputType>Exe</OutputType>" >> $default_csproj_file
echo "  <TargetFramework>net5.0</TargetFramework>" >> $default_csproj_file
echo "  <RootNamespace>$default_root_namespace</RootNamespace>" >> $default_csproj_file
echo " </PropertyGroup>" >> $default_csproj_file

#dotnet add dotnet-console-wrapper.csproj package Microsoft.Azure.DocumentDB.Core -v 1.0.0

package_references=()
versions=()
while IFS= read -r line
do
    if [[ $line =~ ^\/\/auto\-pilot\ add\ .*$ ]]; then
        IFS=' ' read -ra array <<< "$line"

        package_references+=($(echo ${array[2]} | tr -d '\r'))
        versions+=($(echo ${array[3]} | tr -d '\r'))
    fi
done < $1

if [ ${#package_references[@]} -gt 0 ]; then
    echo " <ItemGroup>" >> $default_csproj_file
    for (( i=0; i<${#package_references[@]}; i++ )); do 
        echo "  <PackageReference Include=\"${package_references[$i]}\" Version=\"${versions[$i]}\" />" >> $default_csproj_file
    done
    echo " </ItemGroup>" >> $default_csproj_file
fi

echo "</Project>" >> $default_csproj_file

dotnet run
cd $current_dir
#rm -rf $ephimeral_dir
