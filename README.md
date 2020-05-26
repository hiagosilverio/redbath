[![Codacy Badge](https://api.codacy.com/project/badge/Grade/323eaa7b39a84234a311d5023650c3a0)](https://www.codacy.com/manual/hiago.silverioest/redbath?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=hiagosilverio/redbath&amp;utm_campaign=Badge_Grade)
![GitHub issues](https://img.shields.io/github/issues-raw/hiagosilverio/redbath) 

# RedBath | 0.1.9

A batch script reader to read batch scripts throught command prompt

## Getting Started

Before to sent a stable release, in development branch you will need to:

- Download **redbath.zip**
- Extract the zip into **C:** drive or Windows installation drive **(E:\, F:\ ...)**
- Rename the main folder to **a.redbath**
- Go to the **bin** folder
- Execute **redbath.bat** with double click
- After it starts
- Type **2** to select **List redbath scripts** and press **Enter**
- Type **helloWorld** or **helloWorld.bat**
- Press **Enter**
- You are done..

### Other functions

Redbath also include **PATH injection** but this is in progress, maybe will appear complete in a stable build.

Include **mainfolder\bin** as path and execute the command as follow:

And the prompt command will show a list of red scripts
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
```
red run script helloWorld
```
```
Output:

...

The file was found

Running script..

redbath executed sucessfully..
```
The prompt command will run the redbath script **helloWorld.bat**

CLI functions are in development.. doesn't not include at all in this version

### Prerequisites

Windows 8.1 or above

## Built With

* [Batch](https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/windows-commands) - The main script language

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/hiagosilverio/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/hiagosilverio/redbath/tags). 

## Authors

* **Hiago Silvério** - *Initial work* - [Hiago Silvério](https://github.com/hiagosilverio)

## License

This project is licensed under the GPL 3.0 License - see the [LICENSE.md](LICENSE.md) file for details



