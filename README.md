[![Codacy Badge](https://api.codacy.com/project/badge/Grade/323eaa7b39a84234a311d5023650c3a0)](https://www.codacy.com/manual/hiago.silverioest/redbath?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=hiagosilverio/redbath&amp;utm_campaign=Badge_Grade)
![GitHub issues](https://img.shields.io/github/issues-raw/hiagosilverio/redbath) 

# RedBath | 0.1.9 - Alpha

A batch script reader to read batch scripts throught command prompt

## Getting Started

Follow this steps in the development branch to set up:

-   Download [redbath-0.1.9.zip](https://github.com/hiagosilverio/redbath/releases/tag/0.1.9) 
-   Extract the zip with the main folder
-   Go to the **bin** folder
-   Execute **redbath.bat** with double click
-   After it starts
-   Type **2** to select **List redbath scripts** and press **Enter**
-   Type **helloWorld** or **helloWorld.bat**
-   Press **Enter**
-   You are done..

Memo: If the helloWorld not run properly in this alpha version, not mean that other stuff will not run, but this is the first step to run. If you are having some throuble during this process, please submit a new issue with label named bug so that way could verify if something is wrong 

### Other functions

Redbath also include **PATH injection** but this is in progress, maybe will appear the complete feature in a stable build.

If you want to use CLI functions include **Drive:\path\redbath-0.1.9\bin** as an enviroment path and execute the command.

**Run the prompt command and type as follow:**

red show scripts - show a list of redbath scripts
```
red show scripts
```
```
Output:

- script.bat
- script.bat
- script.bat

Type the script name:
```
red run script [scriptname] - run the redbath script 
```
red run script helloWorld
```
```
Output:

The file was found

Running script..

redbath executed sucessfully..
```
The prompt command will run the redbath script **helloWorld.bat**

CLI functions are in development, not included any support in this version.

Doesn't support custom scripts at CLI, only redbath scripts.

### Prerequisites

**Windows 8x**

  - Batch script knowledge, to create new custom scripts at custom folder.. not necessary to run standard scripts.
## Built With

  *   [Batch](https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/windows-commands) - The main script language

## Contributing

-- Under construction --

Please read [CONTRIBUTING.md](https://gist.github.com/hiagosilverio/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to the repo.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/hiagosilverio/redbath/tags). 

## Authors

*   **Hiago Silvério** - *Initial work* - [Hiago Silvério](https://github.com/hiagosilverio)

## License

This project is licensed under the GPL 3.0 License - see the [LICENSE](LICENSE) file for details



