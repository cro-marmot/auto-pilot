# auto-pilot

Execute C# code snippets (standalone *.cs files) from the terminal. No need to create a c# project with all the config files required or additional directory structures.

Super simple, yet super helpful when you don't want to be goofing around with complex Shell scripting. Move all the hard parts to C# and then call your main() from the command line.

## Params need:
- *$1* is the directory that will hold the ephemeral dotnet console project that will be used as a wrapper.
- *$2* is the name of the root namespace. This must match with the namespace provided in the .cs file that will be used as *Program.cs*.
- *$3* is the *.cs file that will be used as Program cs.

## Usage:

Make _auto-pilot.sh_ executable:

`chmod +x auto-pilot.sh`

Execute _auto-pilot.sh_:

`./auto-pilot.sh /Users/carantesk/ephemeral-project-dir root_namespace /Users/carantesk/snippets/standalone.cs`

If you are on _macOS_ and you want to make me feel proud :purple_heart: , you can add _auto-pilot_ to your _bin_.

`cd /usr/local/bin` and then `ln -sfn /the/file/path/in/which/you/downloaded/auto-pilot.sh auto-pilot`

- -s Create a symbolic link.
- -f If the proposed link (link_name) already exists, then unlink it so that the link may occur. (The -f option overrides any previous -i options.)
- -n If the link_name or link_dirname is a symbolic link, do not follow it.  This is most useful with the -f option, to replace a symlink which may point to a directory.

Now you can type `auto-pilot` instead of `./auto-pilot.sh`. :smiling_imp:

Run `ls -la` to check that the _symlink_ was created correctly.

You're welcome!

## Requirements:

*.NET SDKs installed:*
  - 5.0.100

*.NET runtimes installed:*
  - Microsoft.AspNetCore.App 5.0.0
  - Microsoft.NETCore.App 5.0.0

## Limitations:

- There is currently no way to pass _params_ to main()... the walkaround is to have the Shell script write a *.json file with all the values that are needed by main() and then read them in main() as a config file.
- I still need to test how this works with external dependencies that need to be restored via Nugget using *PM* (Package Manager).
