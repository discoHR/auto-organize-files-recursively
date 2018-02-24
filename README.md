# auto-organize-files-recursively
Script for automatic recursive organization of files from the current directory

How many times you downloaded thousands of disk images for your Gotek, 1541U2+ or DivIDE
but device of your choice does not cope well with large amounts of files per directory?

Simple solution is here. This script will automatically gather all the files from the
current directory and organize them into two level subdirectories keeping the number of
files per directory to 100 whenever possible.

Here is an example of directory structure generated

```
├── 0-9
│   └── 100-8bi
├── a-e
│   ├── abn-ami
│   ├── ami-bab
│   ├── bab-bio
│   ├── bir-c64
│   ├── c64-cla
│   ├── cla-cyb
│   ├── cyb-dig
│   ├── dig-diz
│   ├── diz-ede
│   └── edg-ext
├── f-j
│   ├── f1s-fou
│   ├── fou-gli
│   ├── gli-har
│   ├── har-ima
│   ├── ima-jun
│   └── jus-jus
├── k-o
│   ├── kad-mad
│   ├── mad-meg
│   ├── meg-mir
│   ├── mir-mus
│   ├── mus-mus
│   ├── mus-mus-02
│   ├── mus-nig
│   ├── nig-ope
│   └── ope-ozo
├── p-t
│   ├── paa-pow
│   ├── pow-ret
│   ├── ret-sco
│   ├── scr-son
│   ├── son-sou
│   ├── sou-sou
│   ├── sou-sup
│   ├── sup-tek
│   ├── tek-tun
│   └── tun-twi
└── u-z
    ├── u96-voi
    ├── voy-zis
    └── zis-zoo
```

**CAUTION!
THERE ARE NO WARNINGS AND NO QUESTION ASKED, ALL FILES FROM THE CURRENT DIRECTORY AND
ALL SUBDIRECTORIES WILL BE REORGANIZED SO MAKE SURE YOU'RE IN THE CORRECT DIRECTORY
BEFORE RUNNING THIS SCRIPT! YOU HAVE BEEN WARNED! USE AT OWN RISK! MAKE A BACKUP BEFORE
USING!**

## How to use

Copy the script to ~/bin, make it executable (chmod +x), mount the USB stick if it's
not already mounted, cd to it and run the script. That's it.
