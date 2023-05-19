To launch the finished game:
1. Download the packaged game via the Game-Dungeon-for-beta-testing\Game App EXE path or by following the link.
2. Install the "MATLAB Runtime" package for version 9.8 (R2020a) https://www.mathworks.com/products/compiler/matlab-runtime.html . 
3. Run the file DungeonTester.exe

Для запуска готовой игры:
1. Скачайте упакованную игру по пути Game-Dungeon-for-beta-testing\Game App EXE или по ссылке.
2. Установите пакет "MATLAB Runtime" для версии 9.8 (R2020a) https://www.mathworks.com/products/compiler/matlab-runtime.html. 
3. Запустите файл DungeonTester.exe

DungeonTester Executable

1. Prerequisites for Deployment 

Verify that version 9.8 (R2020a) of the MATLAB Runtime is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter
  
    >>mcrinstaller
      
at the MATLAB prompt.
NOTE: You will need administrator rights to run the MATLAB Runtime installer. 

Alternatively, download and install the Windows version of the MATLAB Runtime for R2020a 
from the following link on the MathWorks website:

    https://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler documentation  
in the MathWorks Documentation Center.

2. Files to Deploy and Package

Files to Package for Standalone 
================================
-DungeonTester.exe
    Note: if end users are unable to download the MATLAB Runtime using the
    instructions in the previous section, include it when building your 
    component by clicking the "Runtime included in package" link in the
    Deployment Tool.
-This readme file 



3. Definitions

For information on deployment terminology, go to
https://www.mathworks.com/help and select MATLAB Compiler >
Getting Started > About Application Deployment >
Deployment Product Terms in the MathWorks Documentation
Center.




