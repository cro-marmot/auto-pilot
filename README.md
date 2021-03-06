# auto-pilot

Execute C# code snippets (standalone *.cs files) from the terminal. No need to create a c# project with all the config files required or additional directory structures.

Super simple, yet super helpful when you don't want to be goofing around with complex Shell scripting. Move all the hard parts to C# and then call your main() from the command line.

## Params need
- *$1* is the directory that will hold the ephemeral dotnet console project that will be used as a wrapper.
- *$2* is the name of the root namespace. This must match with the namespace provided in the .cs file that will be used as *Program.cs*.
- *$3* is the *.cs file that will be used as Program cs.

> :x: Please note that *$1* and all it's contents will be removed to create the dotnet console project.

## Usage

Make _auto-pilot.sh_ executable with `chmod +x auto-pilot.sh`.

### Example 1

Use `/Users/carantesk/ephemeral-project-dir` as the directory in which the ephemeral dotnet project will be created.

Use `root_namespace` as the root namespace in which the *Program* class with the *static void Main(string[] args)* can be found.

Use `/Users/carantesk/snippets/standalone.cs` as the C# file that we want to run.

Run _auto-pilot.sh_: `./auto-pilot.sh /Users/carantesk/ephemeral-project-dir root_namespace /Users/carantesk/snippets/standalone.cs`.

If you are on _macOS_ and you want to make me feel proud :purple_heart: , you can add _auto-pilot_ to your _bin_: `cd /usr/local/bin` and then `ln -sfn /the/file/path/in/which/you/downloaded/auto-pilot.sh auto-pilot`.

|Param|Notes|
|---|---|
|s|Create a symbolic link.|
|f|If the proposed link (link_name) already exists, then unlink it so that the link may occur. (The -f option overrides any previous -i options.)|
|n|If the link_name or link_dirname is a symbolic link, do not follow it.  This is most useful with the -f option, to replace a symlink which may point to a directory.|

You're welcome! Taken from `man ln`.

Now you can type `auto-pilot` instead of `./auto-pilot.sh`. :smiling_imp:

Run `ls -la` to check that the _symlink_ was created correctly.

## Requirements

*.NET SDKs installed:*
  - 5.0.100

*.NET runtimes installed:*
  - Microsoft.AspNetCore.App 5.0.0
  - Microsoft.NETCore.App 5.0.0

## Known limitations

- There is currently no way to pass _params_ to main()... the walkaround is to have the Shell script write a *.json file with all the values that are needed by main() and then read them in main() as a config file.
- I still need to test how this works with external dependencies that need to be restored via Nugget using *PM* (Package Manager). Since `dotnet run` implicitly has a `dotnet restore` there should be no problem as long as the dependencies are declared in some way...
