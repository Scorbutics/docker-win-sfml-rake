FROM mcr.microsoft.com/windows/servercore:1909

RUN curl.exe -o 7za920.zip https://www.7-zip.org/a/7za920.zip \
    && mkdir 7z \
    && tar -C 7z -xf 7za920.zip 7za.exe  \
    && setx /M PATH "%CD%\7z;%PATH%" \
    && del 7za920.zip

RUN curl.exe -L -o msys2-x86-latest.tar.xz http://repo.msys2.org/distrib/i686/msys2-base-i686-20200517.tar.xz \
    && 7za.exe x msys2-x86-latest.tar.xz \
    && 7za.exe x msys2-x86-latest.tar \
    && setx /M PATH "%CD%\msys32;%PATH%" \
    && del msys2-x86-latest.tar \
    && del msys2-x86-latest.tar.xz

RUN curl.exe -L -o ruby_dev.7z https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.6.6-1/rubyinstaller-2.6.6-1-x86.7z \
    && 7za.exe x ruby_dev.7z \
    && setx /M PATH "%CD%\rubyinstaller-2.6.6-1-x86\bin\ruby_builtin_dlls;%PATH%" \
    && setx /M PATH "%CD%\rubyinstaller-2.6.6-1-x86\bin;%PATH%"

RUN ridk enable && gem install rake-compiler

RUN powershell Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
RUN scoop install cmake git wget