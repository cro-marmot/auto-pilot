# auto-pilot

Execute C# code snippets (standalone *.cs files) from the terminal. No need to create a c# project with all the config files required or additional directory structures.

Super simple, yet super helpful when you don't want to be goofing around with complex Shell scripting. Move all the hard parts to C# and then call your main() from the command line.

## Requirements:

*.NET SDKs installed:*
  - 5.0.100
*.NET runtimes installed:*
  - Microsoft.AspNetCore.App 5.0.0
  - Microsoft.NETCore.App 5.0.0

## Limitations:

- There is currently no way to pass _params_ to main()... the walkaround is to have the Shell script write a *.json file with all the values that are needed by main() and then read them in main() as a config file.
